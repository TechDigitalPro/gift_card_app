import 'package:flutter/material.dart';
import 'package:gift_card/extentions/widget_extensions.dart';
import 'package:gift_card/model/common/user_model.dart';
import 'package:gift_card/views/main/main_view.dart';
import '../../model/common/payment_model.dart';
import '../base_view_model.dart';

class PaymentViewModel extends BaseViewModel with WidgetsBindingObserver{
  String? token;
  UserModel? userModel;
  PaymentModel? paymentModel;

  initialize(BuildContext context, PaymentModel? payment) async {
    WidgetsBinding.instance.addObserver(this);
    paymentModel = payment;
    token = await sharedService.getToken();
    userModel = await sharedService.getUser();
      
    notifyListeners();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  onClickBack(BuildContext context) {
    const MainView().launch(context, isNewTask: true);
  }
}
