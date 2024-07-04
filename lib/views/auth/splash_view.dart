import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../utils/system_utils.dart';
import '../../../utils/color_utils.dart';
import '../../view_models/auth/splash_view_model.dart';


class SplashView extends StatefulWidget {
  const SplashView({super.key,});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with WidgetsBindingObserver{

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      viewModelBuilder: () => SplashViewModel(),
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


  buildWidget(BuildContext context, SplashViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorTransparent);
    var height = MediaQuery.of(context).size.height;

    return WillPopScope(
        child: Scaffold(
          body: Container(
            height: height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    ColorUtils.appColorPrimaryDark,
                    ColorUtils.appColorPrimaryDark,
                    ColorUtils.appColorPrimary
                  ],
                )),
              child: Container(
                
              )
            ),
        ),
        onWillPop: () {
          return Future.value(false);
        });
  }
}