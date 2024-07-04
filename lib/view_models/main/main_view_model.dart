import 'package:flutter/material.dart';
import 'package:gift_card/extentions/widget_extensions.dart';
import 'package:gift_card/model/common/user_model.dart';
import 'package:gift_card/utils/widget_utils.dart';
import 'package:gift_card/views/auth/login_view.dart';
import 'package:gift_card/views/main/qr_scanner_view.dart';
import '../base_view_model.dart';

class MainViewModel extends BaseViewModel with WidgetsBindingObserver{
  String? token;
  UserModel? userModel;

  initialize(BuildContext context,) async {
    WidgetsBinding.instance.addObserver(this);
    token = await sharedService.getToken();
    userModel = await sharedService.getUser();
      
    notifyListeners();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  onClickScanQRCode(BuildContext context) {
    const QrScannerView().launch(context);
  }

  onLogout(BuildContext context) async{
    showLoading();
    await Future.delayed(const Duration(seconds: 2)).then((value) => {
      hideLoading(),
      sharedService.saveToken(''),
      sharedService.saveUser(null),
      LoginView().launch(context, isNewTask: true),
    });
  }
}
