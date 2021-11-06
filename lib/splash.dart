

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ticketing/dashboard.dart';
import 'package:mobile_ticketing/login.dart';
import 'package:mobile_ticketing/screens/HealthFullApp.dart';
import 'package:mobile_ticketing/screens/loginPage.dart';
import 'package:mobile_ticketing/utils/SizeConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'model/User.dart';


class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage>{

  int? isLogin = 0;
  late User user;

  
  Future<void> _getLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('isLogin') != null)  isLogin = prefs.getInt('isLogin');
    if (prefs.getString('user') != null) {
      Map<String, dynamic> userMap = jsonDecode(prefs.getString('user')!);
      user = User.fromJson(userMap);
    }
  }


  @override
  initState()  {

    Future.delayed(Duration(seconds: 3), () async {
      await _getLogin();
        isLogin == 1 ? 
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => HealthFullApp(user: user,))) :
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));

      });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    MySize().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image.asset(
              'assets/logo/logo.png',
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width / 2,
            ),
          ),
        ],
      ),
    );
  }


}