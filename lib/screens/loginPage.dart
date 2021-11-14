/*
* File : Login
* Version : 1.0.0
* */


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile_ticketing/model/User.dart';
import 'package:mobile_ticketing/screens/HealthFullApp.dart';
import 'package:mobile_ticketing/services/api_service.dart';
import 'package:mobile_ticketing/utils/SizeConfig.dart';
import 'package:provider/provider.dart';
import '../../AppTheme.dart';
import '../../AppThemeNotifier.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ApiService api = ApiService();
  late bool loginSuccess;
  bool? _passwordVisible = true, _check = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late ThemeData themeData;

  Future clickLogin(TextEditingController login, TextEditingController password) {
    Future<User?> futureUser = api.login(login, password);
    futureUser.then((payload) {
      setState(() {
        if(payload != null) this.loginSuccess = true;
      });
    });
    return futureUser;
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getThemeFromThemeMode(1),
      home: Scaffold(
          body: Stack(
            children: <Widget>[
              ClipPath(
                  clipper: _MyCustomClipper(context),
                  child: Container(
                    alignment: Alignment.center,
                    color: themeData.colorScheme.background,
                  )),
              Positioned(
                left: 30,
                right: 30,
                top: MediaQuery.of(context).size.height * 0.2,
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Card(
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 16, bottom: 16),
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: 24, top: 8),
                              child: Text(
                                "LOGIN",
                                style: AppTheme.getTextStyle(
                                    themeData.textTheme.headline6,
                                    fontWeight: 600),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 16,
                                  right: 16),
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    controller: usernameController,
                                    style: AppTheme.getTextStyle(
                                        themeData.textTheme.bodyText1,
                                        letterSpacing: 0.1,
                                        color: Colors.black,
                                        fontWeight: 500),
                                    decoration: InputDecoration(
                                      hintText: "Username",
                                      hintStyle: AppTheme.getTextStyle(
                                          themeData.textTheme.subtitle2,
                                          letterSpacing: 0.1,
                                          color: Colors.grey,
                                          fontWeight: 500),
                                      prefixIcon:
                                      Icon(MdiIcons.account),
                                    ),
                                  ),
                                  Container(
                                    margin:
                                    EdgeInsets.only(top: 16),
                                    child: TextFormField(
                                      controller: passwordController,
                                      style: AppTheme.getTextStyle(
                                          themeData.textTheme.bodyText1,
                                          letterSpacing: 0.1,
                                          color: Colors.black,
                                          fontWeight: 500),
                                      decoration: InputDecoration(
                                        hintText: "Password",
                                        hintStyle: AppTheme.getTextStyle(
                                            themeData.textTheme.subtitle2,
                                            letterSpacing: 0.1,
                                            color: Colors.grey,
                                            fontWeight: 500),
                                        prefixIcon:
                                        Icon(MdiIcons.lockOutline),
                                        suffixIcon: IconButton(
                                          icon: Icon(_passwordVisible!
                                              ? MdiIcons.eyeOffOutline
                                              : MdiIcons.eyeOutline),
                                          onPressed: () {
                                            setState(() {
                                              _passwordVisible =
                                              !_passwordVisible!;
                                            });
                                          },
                                        ),
                                      ),
                                      obscureText: _passwordVisible!,
                                    ),
                                  ),
                                  Container(
                                    margin:
                                    EdgeInsets.only(top: 16),
                                    alignment: Alignment.centerRight,
                                    child: Text("Forgot Password?",
                                        style: AppTheme.getTextStyle(
                                            themeData.textTheme.bodyText2,
                                            fontWeight: 500)),
                                  ),

                                  Container(
                                    margin:
                                    EdgeInsets.only(top: 16),
                                    width:
                                    MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(24)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: themeData
                                              .colorScheme.primary
                                              .withAlpha(18),
                                          blurRadius: 3,
                                          offset: Offset(0, 1),
                                        ),
                                      ],
                                    ),
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            padding: MaterialStateProperty.all(Spacing.xy(16, 0))
                                        ),
                                        onPressed: () async {
                                          User? user = await clickLogin(usernameController, passwordController);
                                          if (loginSuccess) {
                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login Berhasil!')));
                                            Navigator.of(context)
                                                .pushReplacement(MaterialPageRoute(builder: (_) => HealthFullApp(user : user)));

                                          } else  {
                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Username dan Password Salah!')));
                                          }

                                        },
                                        child: Text("LOGIN",
                                            style: AppTheme.getTextStyle(
                                                themeData.textTheme.button,
                                                fontWeight: 600,
                                                color: themeData
                                                    .colorScheme.onPrimary,
                                                letterSpacing: 0.5))),
                                  ),

                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 16),
                        child: Center(
                          child: RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "Don't have an Account? ",
                                  style: AppTheme.getTextStyle(
                                      themeData.textTheme.bodyText2,
                                      fontWeight: 500)),
                              TextSpan(
                                  text: " Register",
                                  style: AppTheme.getTextStyle(
                                      themeData.textTheme.bodyText2,
                                      fontWeight: 600,
                                      color:
                                      themeData.colorScheme.primary)),
                            ]),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

            ],
          )),
    );
  }
}

class _MyCustomClipper extends CustomClipper<Path> {
  final BuildContext _context;

  _MyCustomClipper(this._context);

  @override
  Path getClip(Size size) {
    final path = Path();
    Size size = MediaQuery.of(_context).size;
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.3);
    path.lineTo(0, size.height * 0.6);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
