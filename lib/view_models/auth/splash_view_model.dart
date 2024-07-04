import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gift_card/model/common/user_model.dart';
import 'package:gift_card/views/auth/login_view.dart';
import 'package:gift_card/views/main/main_view.dart';
import 'package:nb_utils/nb_utils.dart';
import '../base_view_model.dart';

class SplashViewModel extends BaseViewModel with WidgetsBindingObserver{
  UserModel? user;
  bool isAuto = true;
  bool isFirst = true;
  String locale = 'en';

  initialize(BuildContext context,) async {
    WidgetsBinding.instance.addObserver(this);
    isFirst = await sharedService.getIsFirst();
    user = await sharedService.getUser();

    if(user != null){        
        await Future.delayed(const Duration(milliseconds: 100)).then((value) => {
          const MainView().launch(context),
        });
    }else {
      await Future.delayed(const Duration(milliseconds: 100)).then((value) => {
          LoginView().launch(context),
        });
    }
      
    notifyListeners();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }
}
