import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_ticketing/intro.dart';
import 'package:mobile_ticketing/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

int? isviewed;
Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isviewed = prefs.getInt('IntroScreen');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Music Max',
        // theme: ThemeData(
        //   accentColor: Colors.blue,
        // ),
        home: isviewed != 0 ? IntroScreen() : SplashScreenPage(),
      );
    });
  }
}
