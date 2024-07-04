import 'package:flutter/material.dart';
import 'package:gift_card/utils/size_utils.dart';
import 'package:gift_card/utils/string_utils.dart';
import 'package:gift_card/view_models/main/payment_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../utils/system_utils.dart';
import '../../../utils/color_utils.dart';
import '../../model/common/payment_model.dart';
import '../../utils/image_utils.dart';
import '../../utils/widget_utils.dart';


// ignore: must_be_immutable
class PaymentView extends StatelessWidget {
  PaymentView({super.key, this.payment});

  PaymentModel? payment;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PaymentViewModel>.reactive(
      viewModelBuilder: () => PaymentViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onViewModelReady: (model) => model.initialize(context, payment),
    );
  }

  buildWidget(BuildContext context, PaymentViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorTransparent);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return WillPopScope(
        child: Scaffold(
          body: Container(
            height: height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    ColorUtils.appColorWhite,
                    ColorUtils.appColorWhite,
                    ColorUtils.appColorWhite
                  ],
                )),
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: height * 0.05,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            textView(
                              StringUtils.txtWelcome,
                              textColor: ColorUtils.appColorBlack,
                              fontSize: SizeUtils.textSizeNormal
                            ),
                            model.userModel == null
                            ? Container()
                            : textView(
                              '${model.userModel!.firstName} ${model.userModel!.lastName}',
                              textColor: ColorUtils.appColorBlack,
                              fontSize: SizeUtils.textSizeLarge,
                              fontWeight: FontWeight.bold
                            ),
                          ],
                        ),
                        Expanded(child: Container()),
                        ClipOval(
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorUtils.appColorGreyWhite,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: 
                              (model.userModel == null
                              ||  model.userModel!.userImage == null 
                              || model.userModel!.userImage!.isEmpty) ?
                              Image.asset(
                                ImageUtils.imgIcLogo,
                                width:  50,
                                height: 50,
                                fit: BoxFit.cover,
                              )
                              : CachedNetworkImage(
                                imageUrl: model.userModel!.userImage ?? '',
                                width:  50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Card(
                      color: ColorUtils.appColorGreyWhite,
                      shadowColor: ColorUtils.appColorBlack,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                textView(
                                  '${StringUtils.txtPointBalance}:',
                                  textColor: ColorUtils.appColorBlack,
                                  fontSize: SizeUtils.textSizeMedium
                                ),
                                Expanded(child: Container()),
                                textView(
                                  model.paymentModel == null
                                  ? ''
                                  : model.paymentModel!.oldPoint.toString(),
                                  textColor: ColorUtils.appColorBlack,
                                  fontSize: SizeUtils.textSizeNormal,
                                  fontWeight: FontWeight.bold
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: <Widget>[
                                textView(
                                  '${StringUtils.txtEarnedPoint}:',
                                  textColor: ColorUtils.appColorBlack,
                                  fontSize: SizeUtils.textSizeMedium
                                ),
                                Expanded(child: Container()),
                                textView(
                                  model.paymentModel == null
                                  ? ''
                                  : model.paymentModel!.earnedPoint.toString(),
                                  textColor: ColorUtils.appColorBlack,
                                  fontSize: SizeUtils.textSizeNormal,
                                  fontWeight: FontWeight.bold
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: <Widget>[
                                textView(
                                  '${StringUtils.txtNewBalance}:',
                                  textColor: ColorUtils.appColorBlack,
                                  fontSize: SizeUtils.textSizeMedium
                                ),
                                Expanded(child: Container()),
                                textView(
                                  model.paymentModel == null
                                  ? ''
                                  : model.paymentModel!.newPoint.toString(),
                                  textColor: ColorUtils.appColorBlack,
                                  fontSize: SizeUtils.textSizeNormal,
                                  fontWeight: FontWeight.bold
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ),
                    const SizedBox(height: 5),
                    Card(
                      color: ColorUtils.appColorGreyWhite,
                      shadowColor: ColorUtils.appColorBlack,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                textView(
                                  '${StringUtils.txtStartingBalance}:',
                                  textColor: ColorUtils.appColorBlack,
                                  fontSize: SizeUtils.textSizeMedium
                                ),
                                Expanded(child: Container()),
                                textView(
                                  model.paymentModel == null 
                                  ? '' 
                                  : StringUtils.txtSymbolUSD + model.paymentModel!.startBalance.toString(),
                                  textColor: ColorUtils.appColorBlack,
                                  fontSize: SizeUtils.textSizeNormal,
                                  fontWeight: FontWeight.bold
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: <Widget>[
                                textView(
                                  '${StringUtils.txtDebit}:',
                                  textColor: ColorUtils.appColorBlack,
                                  fontSize: SizeUtils.textSizeMedium
                                ),
                                Expanded(child: Container()),
                                textView(
                                  model.paymentModel == null 
                                  ? '' 
                                  : StringUtils.txtSymbolUSD + model.paymentModel!.amount.toString(),
                                  textColor: ColorUtils.appColorBlack,
                                  fontSize: SizeUtils.textSizeNormal,
                                  fontWeight: FontWeight.bold
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: <Widget>[
                                textView(
                                  '${StringUtils.txtNewBalance}:',
                                  textColor: ColorUtils.appColorBlack,
                                  fontSize: SizeUtils.textSizeMedium
                                ),
                                Expanded(child: Container()),
                                textView(
                                  model.paymentModel == null 
                                  ? '' 
                                  : StringUtils.txtSymbolUSD + model.paymentModel!.newBalance.toString(),
                                  textColor: ColorUtils.appColorBlack,
                                  fontSize: SizeUtils.textSizeNormal,
                                  fontWeight: FontWeight.bold
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ),

                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        alignment: Alignment.center,
                        child: 
                          (model.paymentModel == null
                          ||  model.paymentModel!.receiptUrl == null 
                          || model.paymentModel!.receiptUrl!.isEmpty) ?
                          Image.asset(
                            ImageUtils.imgIcLogo,
                            width:  width,
                            fit: BoxFit.cover,
                          )
                          : CachedNetworkImage(
                            imageUrl: model.paymentModel!.receiptUrl ?? '',
                            fit: BoxFit.cover,
                          ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: RoundButton(
                              isStroked: false,
                              backgroundColor: ColorUtils.appColorBlue,
                              textContent: StringUtils.txtConfirm,
                              textSize: SizeUtils.textSizeMedium,
                              isAllCaps: true,
                              radius: 30,
                              onPressed: () {
                                model.onClickBack(
                                  context,
                                );
                              }),
                        ),
                        SizedBox(height: height * 0.01,)
                      ],
                    )
                  ],
                ),
              )
            ),
        ),
        onWillPop: () {
          model.onClickBack(context);
          return Future.value(false);
        });
  }
}