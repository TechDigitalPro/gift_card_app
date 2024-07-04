import 'package:flutter/material.dart';
import 'package:gift_card/utils/size_utils.dart';
import 'package:gift_card/utils/string_utils.dart';
import 'package:stacked/stacked.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../utils/system_utils.dart';
import '../../../utils/color_utils.dart';
import '../../utils/image_utils.dart';
import '../../utils/widget_utils.dart';
import '../../view_models/main/main_view_model.dart';


class MainView extends StatefulWidget {
  const MainView({super.key,});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with WidgetsBindingObserver{

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => MainViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onViewModelReady: (model) => model.initialize(context),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }


  buildWidget(BuildContext context, MainViewModel model, Widget? child) {
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
                        IconButton(
                          onPressed: (){
                            model.onLogout(context);
                          }, 
                          icon: Icon(Icons.logout, color: ColorUtils.appColorBlack, size: 24,),
                          splashColor: ColorUtils.appColorBlue,
                        )
                      ],
                    ),
                    SizedBox(height: height * 0.1),
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
                            Container(
                              width: width,
                              alignment: Alignment.center,
                              child: Image.asset(
                                ImageUtils.imgIcLogoRound,
                                width:  100,
                                height: 100,
                                fit: BoxFit.cover,
                              )
                            ),
                            Row(
                              children: <Widget>[
                                textView(
                                  '${StringUtils.txtPointBalance}:',
                                  textColor: ColorUtils.appColorBlack,
                                  fontSize: SizeUtils.textSizeMedium
                                ),
                                Expanded(child: Container()),
                                textView(
                                  model.userModel == null
                                  ? ''
                                  : model.userModel!.point.toString(),
                                  textColor: ColorUtils.appColorBlack,
                                  fontSize: SizeUtils.textSizeNormal,
                                  fontWeight: FontWeight.bold
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: <Widget>[
                                textView(
                                  '${StringUtils.txtAccountBalance}:',
                                  textColor: ColorUtils.appColorBlack,
                                  fontSize: SizeUtils.textSizeMedium
                                ),
                                Expanded(child: Container()),
                                textView(
                                  model.userModel == null 
                                  ? '' 
                                  : StringUtils.txtSymbolUSD + model.userModel!.balance.toString(),
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
                    Expanded(child: Container()),
                    Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: RoundButton(
                              isStroked: false,
                              backgroundColor: ColorUtils.appColorBlue,
                              textContent: StringUtils.txtScanQRCode,
                              textSize: SizeUtils.textSizeMedium,
                              isAllCaps: true,
                              radius: 30,
                              onPressed: () {
                                model.onClickScanQRCode(
                                  context,
                                );
                              }),
                        ),
                        SizedBox(height: height * 0.1,)
                      ],
                    )
                  ],
                ),
              )
            ),
        ),
        onWillPop: () {
          showDialog(
            context: context,
            builder: (BuildContext dlgContext) => const ExitDialog(),
          );
          return Future.value(false);
        });
  }
}