import 'package:flutter/material.dart';
import 'package:gift_card/extentions/widget_extensions.dart';
import 'package:gift_card/model/request/login_req.dart';
import 'package:gift_card/views/auth/fortgot_password_view.dart';
import 'package:gift_card/views/auth/register_view.dart';

import '../../model/response/login_res.dart';
import '../../utils/string_utils.dart';
import '../../utils/widget_utils.dart';
import '../../views/main/main_view.dart';
import '../base_view_model.dart';

class LoginViewModel extends BaseViewModel {
  initialize(BuildContext context) async {
  }

  onClickLogin(BuildContext context, String email, String password) async{
    if(email.isEmpty){
      showMessage(StringUtils.txtPleaseEnterEmail, null);
      return;
    }
    if(password.isEmpty){
      showMessage(StringUtils.txtPleaseEnterPassword, null);
      return;
    }
    
    showLoading();
    try{
      LoginReq req = LoginReq(email: email, password: password, type: 'consumer');
      LoginRes? res = await networkService.doLogin(req);
      hideLoading();
      if(res == null){
        showMessage(StringUtils.txtOpsSomethingWentWrong, null);
      }else {
        if(res.status!){
          sharedService.saveUser(res.user);
          await Future.delayed(const Duration(milliseconds: 100)).then((value) => {
            const MainView().launch(context, isNewTask: true),
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

  onClickForgotPassword(BuildContext context) {
    ForgotPasswordView().launch(context);
  }

  onClickRegister(BuildContext context) {
    RegisterView().launch(context);
  }
}