import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gift_card/utils/color_utils.dart';
import 'package:gift_card/utils/string_utils.dart';
import 'package:gift_card/views/auth/splash_view.dart';

import 'settings/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  setupLocator();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringUtils.txtAppName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: ColorUtils.appColorPrimary,
        primaryColorDark: ColorUtils.appColorBlue, 
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorUtils.appColorAccent),
        brightness: Brightness.light
      ),
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      home: const SplashView(),
    );
  }
}
