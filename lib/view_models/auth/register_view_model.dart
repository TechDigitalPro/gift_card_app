import 'package:flutter/material.dart';
import 'package:gift_card/extentions/widget_extensions.dart';
import 'package:gift_card/model/request/register_req.dart';
import 'package:gift_card/utils/system_utils.dart';

import '../../model/response/login_res.dart';
import '../../utils/string_utils.dart';
import '../../utils/widget_utils.dart';
import '../../views/main/main_view.dart';
import '../base_view_model.dart';

class RegisterViewModel extends BaseViewModel {
  
  initialize(BuildContext context) async {
  }

  onClickRegister(BuildContext context, String firstName, String lastName, String email, String password, String conformPass) async{
    if(firstName.isEmpty){
      showMessage(StringUtils.txtPleaseEnterFirstName, null);
      return;
    }
    if(lastName.isEmpty){
      showMessage(StringUtils.txtPleaseEnterLastName, null);
      return;
    }
    if(email.isEmpty){
      showMessage(StringUtils.txtPleaseEnterEmail, null);
      return;
    }
    if(password.isEmpty){
      showMessage(StringUtils.txtPleaseEnterPassword, null);
      return;
    }
    if(password != conformPass){
      showMessage(StringUtils.txtPasswordNotMatching, null);
      return;
    }

    showLoading();
    try{
      RegisterReq req = RegisterReq(
        email: email, 
        password: password, 
        type: 'consumer',
        firstName: firstName,
        lastName: lastName,
      );
      LoginRes? res = await networkService.doRegister(req);
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

  onClickLogin(BuildContext context) {
    finishView(context);
  }
}