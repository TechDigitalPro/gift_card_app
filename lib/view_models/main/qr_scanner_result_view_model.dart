import 'package:flutter/material.dart';
import 'package:gift_card/model/common/payment_model.dart';
import 'package:gift_card/model/common/qr_model.dart';
import 'package:gift_card/model/request/purchase_req.dart';
import 'package:gift_card/model/response/purchase_res.dart';
import 'package:gift_card/utils/string_utils.dart';
import 'package:gift_card/utils/widget_utils.dart';
import 'package:gift_card/views/main/main_view.dart';
import 'package:gift_card/views/main/payment_view.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../model/common/user_model.dart';
import '../base_view_model.dart';

class QrScannerResultViewModel extends BaseViewModel {
  QrModel? qrCodeModel;
  UserModel? userModel;
  
  initialize(BuildContext context, QrModel? qrModel) async {
    qrCodeModel = qrModel;
    userModel = await sharedService.getUser();

    notifyListeners();
  }

  onClickPay(BuildContext context) async{
    int? point = int.parse(userModel!.point!);
    double? balance = double.parse(userModel!.balance!);
    double? amount = double.parse(qrCodeModel!.amount!);
    int? earnedPoint = (amount * 10).toInt();

    if(balance < amount){
      showMessage(StringUtils.txtBalanceNotEnough, null);
      return;
    }

    showLoading();
    try{
      PurchaseReq req = PurchaseReq(
        businessId: qrCodeModel!.merchantId,
        firstKey: qrCodeModel!.firstKey,
        lastKey: qrCodeModel!.lastKey,
        date: qrCodeModel!.date,
        amount: qrCodeModel!.amount,
        itemId: qrCodeModel!.itemId,
        description: qrCodeModel!.description,
        lat: qrCodeModel!.lat,
        long: qrCodeModel!.long,
        consumerId: userModel!.id,
        email: userModel!.userEmail,
      );
      PurchaseRes? res = await networkService.doPurchaseGift(req);
      hideLoading();
      if(res == null){
        showMessage(StringUtils.txtOpsSomethingWentWrong, null);
      }else {
        if(res.status!){
          PaymentModel paymentModel = PaymentModel(
            newPoint: res.user!.point,
            earnedPoint: earnedPoint.toString(),
            oldPoint: point.toString(),
            startBalance: balance.toString(),
            newBalance: res.user!.balance,
            amount: amount.toString(),
            description: qrCodeModel!.description,
            receiptUrl: ""
          );
          await Future.delayed(const Duration(milliseconds: 100)).then((value) => {
            sharedService.saveUser(res.user),
            PaymentView(payment: paymentModel,).launch(context),
          });
        }else {
          showMessage(res.message ?? StringUtils.txtOpsSomethingWentWrong, null);
        }
      }
    }catch(e){
      debugPrint(e.toString());
      hideLoading();
    }
  }

  onBackClicked(BuildContext context) {
    const MainView().launch(context, isNewTask: true);
  }
}