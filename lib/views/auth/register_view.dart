import 'package:flutter/material.dart';
import 'package:gift_card/view_models/auth/register_view_model.dart';
import 'package:stacked/stacked.dart';

import '../../utils/color_utils.dart';
import '../../utils/size_utils.dart';
import '../../utils/string_utils.dart';
import '../../utils/system_utils.dart';
import '../../utils/widget_utils.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final TextEditingController textEditingControllerFirstName = TextEditingController();
  final TextEditingController textEditingControllerLastName = TextEditingController();
  final TextEditingController textEditingControllerEmail = TextEditingController();
  final TextEditingController textEditingControllerPassword = TextEditingController();
  final TextEditingController textEditingControllerConfirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
      viewModelBuilder: () => RegisterViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onViewModelReady: (viewModel) => viewModel.initialize(context),
    );
  }

  buildWidget(BuildContext context, RegisterViewModel model, Widget? child) {
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
              automaticallyImplyLeading: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: ColorUtils.appColorBlack,),
                splashRadius: 20,
                onPressed: (){
                  finishView(context);
                },
              )
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
                        child: textView(StringUtils.txtRegister,
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
                            hintText: StringUtils.txtFirstName,
                            isPassword: false,
                            isSecure: false,
                            textInputType: TextInputType.name,
                            mController: textEditingControllerFirstName,
                            borderColor: ColorUtils.appColorBlack_10,
                            borderRadius: 30,
                            contentPadding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
                            textColor: ColorUtils.appColorBlack,
                          ),
                          const SizedBox(
                              height: 10,
                            ),
                          EditTextFieldRound(
                            hintText: StringUtils.txtLastName,
                            isPassword: false,
                            isSecure: false,
                            textInputType: TextInputType.name,
                            mController: textEditingControllerLastName,
                            borderColor: ColorUtils.appColorBlack_10,
                            borderRadius: 30,
                            contentPadding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
                            textColor: ColorUtils.appColorBlack,
                          ),
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
                          const SizedBox(
                              height: 10,
                            ),
                          EditTextFieldRound(
                            hintText: StringUtils.txtConfirmPassword,
                            isPassword: true,
                            isSecure: true,
                            mController: textEditingControllerConfirmPassword,
                            borderColor: ColorUtils.appColorBlack_10,
                            borderRadius: 30,
                            contentPadding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
                            textColor: ColorUtils.appColorBlack,
                          ),
                          const SizedBox(
                              height: 20,
                            ),
                          Container(
                            alignment: Alignment.center,
                            child: RoundButton(
                                isStroked: false,
                                backgroundColor: ColorUtils.appColorPrimaryDark,
                                textContent: StringUtils.txtRegister,
                                textSize: SizeUtils.textSizeMedium,
                                isAllCaps: true,
                                radius: 30,
                                onPressed: (){
                                  model.onClickRegister(
                                      context,
                                      textEditingControllerFirstName.text,
                                      textEditingControllerLastName.text,
                                      textEditingControllerEmail.text,
                                      textEditingControllerPassword.text,
                                      textEditingControllerConfirmPassword.text,
                                    );
                                }
                              ),
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                           Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                textView(
                                  StringUtils.txtBackToLogin,
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
                                      textContent: StringUtils.txtLogin,
                                      textSize: SizeUtils.textSizeMedium,
                                      isAllCaps: true,
                                      radius: 30,
                                      onPressed: () {
                                        model.onClickLogin(
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
