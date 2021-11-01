

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ticketing/home.dart';
import 'package:mobile_ticketing/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage>{

  int? isLogin = 0;
  
  Future<void> _getLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('isLogin') != null)  isLogin = prefs.getInt('isLogin');
  }

  @override
  initState()  {
    _getLogin();
    Future.delayed(Duration(seconds: 3), () {
        isLogin == 1 ? 
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => HomePage())) :
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => LoginPage(title: "Login")));

      });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Image.asset(
                'images/mx.png',
                height: 35.h,
                width: 80.w,
              ),
            ),
          ],
        ),
      ),
    );
  }


}