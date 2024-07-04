import 'package:flutter/material.dart';
import 'package:gift_card/extentions/widget_extensions.dart';
import 'package:gift_card/views/auth/login_view.dart';

import '../../utils/string_utils.dart';
import '../../utils/widget_utils.dart';
import '../base_view_model.dart';

class ForgotPasswordViewModel extends BaseViewModel {
  
  initialize(BuildContext context) async {
  }

  onClickSend(BuildContext context, String email) async{
    if(email.isEmpty){
      showMessage(StringUtils.txtPleaseEnterEmail, null);
      return;
    }

    showMessage(StringUtils.txtResetPasswordLinkSent, null);

    LoginView().launch(context, isNewTask: true);
  }
}