import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutx/themes/app_theme.dart';
import 'package:flutx/themes/app_theme_notifier.dart';
import 'package:flutx/utils/spacing.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile_ticketing/dashboard.dart';
import 'package:mobile_ticketing/intro.dart';
import 'package:mobile_ticketing/screens/HealthFullApp.dart';
import 'package:mobile_ticketing/screens/HealthHomeScreen.dart';
import 'package:mobile_ticketing/screens/SelectThemeDialog.dart';
import 'package:mobile_ticketing/splash.dart';
import 'package:mobile_ticketing/utils/SizeConfig.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'AppTheme.dart';
import 'AppThemeNotifier.dart';

int? isviewed;
Future<void> firstTimeVisit() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isviewed = prefs.getInt('IntroScreen') ;
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreenPage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return MaterialApp(
      home: SplashScreenPage(),
    );

  }
}





