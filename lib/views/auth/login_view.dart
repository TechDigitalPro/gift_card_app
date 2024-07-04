import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../utils/color_utils.dart';
import '../../utils/size_utils.dart';
import '../../utils/string_utils.dart';
import '../../utils/system_utils.dart';
import '../../utils/widget_utils.dart';
import '../../view_models/auth/login_view_model.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final TextEditingController textEditingControllerEmail =
      TextEditingController();
  final TextEditingController textEditingControllerPassword =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onViewModelReady: (viewModel) => viewModel.initialize(context),
    );
  }

  buildWidget(BuildContext context, LoginViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorTransparent,
        statusBarIconBrightness: Brightness.light);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
              titleSpacing: 0,
              backgroundColor: ColorUtils.appColorWhite,
              centerTitle: false,
              elevation: 0,
              automaticallyImplyLeading: false,
            ),
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
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        height: height * 0.2,
                        child: textView(StringUtils.txtLogin,
                            textColor: ColorUtils.appColorBlack,
                            fontSize: SizeUtils.textSizeXXXLarge,
                            fontWeight: FontWeight.bold,
                            isCentered: false),
                      ),
                      Container(
                      alignment: Alignment.bottomCenter,
                      padding: EdgeInsets.all(width * 0.05),
                      width: width,
                      child: Column(
                        children: [
                          const SizedBox(
                              height: 10,
                            ),
                          EditTextFieldRound(
                            hintText: StringUtils.txtEmail,
                            isPassword: false,
                            isSecure: false,
                            textInputType: TextInputType.emailAddress,
                            mController: textEditingControllerEmail,
                            borderColor: ColorUtils.appColorBlack_10,
                            borderRadius: 30,
                            contentPadding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
                            textColor: ColorUtils.appColorBlack,
                          ),
                          const SizedBox(
                              height: 10,
                            ),
                          EditTextFieldRound(
                            hintText: StringUtils.txtPassword,
                            isPassword: true,
                            isSecure: true,
                            mController: textEditingControllerPassword,
                            borderColor: ColorUtils.appColorBlack_10,
                            borderRadius: 30,
                            contentPadding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
                            textColor: ColorUtils.appColorBlack,
                          ),
                          Container(
                            padding: const EdgeInsets.all(20),
                            color: ColorUtils.appColorTransparent,
                            child: GestureDetector(
                              child: textViewUnderline(
                                StringUtils.txtForgotPassword,
                                textColor:
                                    ColorUtils.appColorTextLight,
                                fontSize: SizeUtils.textSizeLargeMedium,
                                isCentered: false),
                                onTap: (){
                                  model.onClickForgotPassword(context);
                                },
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: RoundButton(
                                isStroked: false,
                                backgroundColor: ColorUtils.appColorPrimaryDark,
                                textContent: StringUtils.txtLogin,
                                textSize: SizeUtils.textSizeMedium,
                                isAllCaps: true,
                                radius: 30,
                                onPressed: (){
                                  model.onClickLogin(
                                      context,
                                      textEditingControllerEmail.text,
                                      textEditingControllerPassword.text,
                                    );
                                }
                              ),
                          ),
                          SizedBox(
                            height: height * 0.1,
                          ),
                           Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                textView(
                                  StringUtils.txtAreYouNotMember,
                                  textColor: ColorUtils.appColorPrimaryDark,
                                  fontSize: SizeUtils.textSizeNormal,
                                  fontWeight: FontWeight.bold,
                                  isCentered: false),
                                Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                                  child: RoundButton(
                                      isStroked: false,
                                      backgroundColor: ColorUtils.appColorBlue,
                                      textContent: StringUtils.txtRegister,
                                      textSize: SizeUtils.textSizeMedium,
                                      isAllCaps: true,
                                      radius: 30,
                                      onPressed: () {
                                        model.onClickRegister(
                                          context,
                                        );
                                      }),
                                ),
                                SizedBox(
                                  height: height * 0.05,
                                ),
                                
                              ],
                            ),
                        ],
                      ),
                    ),
                ]
              ),
            )
          ),
        ),
        onWillPop: () {
          finishView(context);
          return Future.value(false);
        });
  }
}
