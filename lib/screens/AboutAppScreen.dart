
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile_ticketing/utils/Generator.dart';
import 'package:mobile_ticketing/utils/SizeConfig.dart';
import 'package:provider/provider.dart';

import '../../AppTheme.dart';
import '../../AppThemeNotifier.dart';

class AboutAppScreen extends StatefulWidget {
  @override
  _AboutAppScreenState createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  late ThemeData themeData;
  CustomAppTheme? customAppTheme;
  bool _passwordVisible = false;

  Widget build(BuildContext context) {
    themeData = Theme.of(context);
        customAppTheme = AppTheme.getCustomAppTheme(1);
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.getThemeFromThemeMode(1),
            home: Scaffold(
                appBar: AppBar(
                  backgroundColor: themeData.scaffoldBackgroundColor,
                  elevation: 0,
                 /* leading: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(MdiIcons.chevronLeft),
                  ),*/
                  title: Text("Profil Pengguna",
                      style: AppTheme.getTextStyle(
                          themeData.textTheme.headline6,
                          fontWeight: 600)),
                ),
                backgroundColor: themeData.backgroundColor,
                body: Container(
                  child: ListView(
                    padding: EdgeInsets.only(
                        top: MySize.size32!,
                        left: MySize.size24!,
                        right: MySize.size24!),
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: MySize.size60,
                              height: MySize.size60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage(
                                        "./assets/images/avatar-3.jpg"),
                                    fit: BoxFit.fill),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: MySize.size24!),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "FlutKit",
                                    style: AppTheme.getTextStyle(
                                        themeData.textTheme.subtitle1,
                                        fontWeight: 600,
                                        color:
                                            themeData.colorScheme.onBackground),
                                  ),
                                  Container(
                                    child: Text(
                                      "Flutter Biggest UI KIT",
                                      style: AppTheme.getTextStyle(
                                          themeData.textTheme.subtitle2,
                                          fontWeight: 500,
                                          color: themeData
                                              .colorScheme.onBackground),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: MySize.size8!,
                                      right: MySize.size8!,
                                      top: MySize.size4!,
                                      bottom: MySize.size4!),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(MySize.size4!)),
                                  ),
                                  child: ElevatedButton(
                                      onPressed: () {},
                                      child: Text("LOGOUT",
                                          style: AppTheme.getTextStyle(
                                              themeData
                                                  .textTheme.bodyText2,
                                              fontSize: 10,
                                              fontWeight: 700,
                                              color: themeData.colorScheme
                                                  .onPrimary))
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding:
                        EdgeInsets.only(top: MySize.size36!, left: MySize.size24!, right: MySize.size24!),
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: MySize.size16!),
                              child: TextFormField(
                                style: AppTheme.getTextStyle(
                                    themeData.textTheme.bodyText1,
                                    letterSpacing: 0.1,
                                    color: themeData.colorScheme.onBackground,
                                    fontWeight: 500),
                                decoration: InputDecoration(
                                  hintText: "Name",
                                  hintStyle: AppTheme.getTextStyle(
                                      themeData.textTheme.subtitle2,
                                      letterSpacing: 0.1,
                                      color: themeData.colorScheme.onBackground,
                                      fontWeight: 500),
                                  border:  OutlineInputBorder(
                                      borderRadius:  BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                      borderSide: BorderSide.none),
                                  enabledBorder:  OutlineInputBorder(
                                      borderRadius:  BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                      borderSide: BorderSide.none),
                                  focusedBorder:  OutlineInputBorder(
                                      borderRadius:  BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                      borderSide: BorderSide.none),
                                  filled: true,
                                  fillColor: themeData.colorScheme.background,
                                  prefixIcon: Icon(
                                    MdiIcons.accountOutline,
                                  ),
                                  contentPadding: EdgeInsets.all(0),
                                ),
                                controller:
                                TextEditingController(text: "Marcelina Willis"),
                                textCapitalization: TextCapitalization.sentences,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: MySize.size16!),
                              child: TextFormField(
                                style: AppTheme.getTextStyle(
                                    themeData.textTheme.bodyText1,
                                    letterSpacing: 0.1,
                                    color: themeData.colorScheme.onBackground,
                                    fontWeight: 500),
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  hintStyle: AppTheme.getTextStyle(
                                      themeData.textTheme.subtitle2,
                                      letterSpacing: 0.1,
                                      color: themeData.colorScheme.onBackground,
                                      fontWeight: 500),
                                  border:  OutlineInputBorder(
                                      borderRadius:  BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                      borderSide: BorderSide.none),
                                  enabledBorder:  OutlineInputBorder(
                                      borderRadius:  BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                      borderSide: BorderSide.none),
                                  focusedBorder:  OutlineInputBorder(
                                      borderRadius:  BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                      borderSide: BorderSide.none),
                                  filled: true,
                                  fillColor: themeData.colorScheme.background,
                                  prefixIcon: Icon(
                                    MdiIcons.emailOutline,
                                  ),
                                  contentPadding: EdgeInsets.all(0),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                controller:
                                TextEditingController(text: "nat@gmail.com"),
                                textCapitalization: TextCapitalization.sentences,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: MySize.size16!),
                              child: TextFormField(
                                style: AppTheme.getTextStyle(
                                    themeData.textTheme.bodyText1,
                                    letterSpacing: 0.1,
                                    color: themeData.colorScheme.onBackground,
                                    fontWeight: 500),
                                decoration: InputDecoration(
                                  hintText: "Phone",
                                  hintStyle: AppTheme.getTextStyle(
                                      themeData.textTheme.subtitle2,
                                      letterSpacing: 0.1,
                                      color: themeData.colorScheme.onBackground,
                                      fontWeight: 500),
                                  border:  OutlineInputBorder(
                                      borderRadius:  BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                      borderSide: BorderSide.none),
                                  enabledBorder:  OutlineInputBorder(
                                      borderRadius:  BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                      borderSide: BorderSide.none),
                                  focusedBorder:  OutlineInputBorder(
                                      borderRadius:  BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                      borderSide: BorderSide.none),
                                  filled: true,
                                  fillColor: themeData.colorScheme.background,
                                  prefixIcon: Icon(
                                    MdiIcons.phoneOutline,
                                  ),
                                  contentPadding: EdgeInsets.all(0),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                textCapitalization: TextCapitalization.sentences,
                                controller:
                                TextEditingController(text: "091-987456321"),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: MySize.size16!),
                              child: TextFormField(
                                style: AppTheme.getTextStyle(
                                    themeData.textTheme.bodyText1,
                                    letterSpacing: 0.1,
                                    color: themeData.colorScheme.onBackground,
                                    fontWeight: 500),
                                decoration: InputDecoration(
                                  hintText: "Change Password",
                                  hintStyle: AppTheme.getTextStyle(
                                      themeData.textTheme.subtitle2,
                                      letterSpacing: 0.1,
                                      color: themeData.colorScheme.onBackground,
                                      fontWeight: 500),
                                  border:  OutlineInputBorder(
                                      borderRadius:  BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                      borderSide: BorderSide.none),
                                  enabledBorder:  OutlineInputBorder(
                                      borderRadius:  BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                      borderSide: BorderSide.none),
                                  focusedBorder:  OutlineInputBorder(
                                      borderRadius:  BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                      borderSide: BorderSide.none),
                                  filled: true,
                                  fillColor: themeData.colorScheme.background,
                                  prefixIcon: Icon(
                                    MdiIcons.lockOutline,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _passwordVisible
                                          ? MdiIcons.eyeOutline
                                          : MdiIcons.eyeOffOutline,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
                                  contentPadding: EdgeInsets.all(0),
                                ),
                                textCapitalization: TextCapitalization.sentences,
                                obscureText: _passwordVisible,
                              ),
                            ),
                            Container(
                              margin:  EdgeInsets.only(top: MySize.size24!),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(MySize.size8!)),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                    themeData.colorScheme.primary.withAlpha(20),
                                    blurRadius: 3,
                                    offset:
                                    Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all(Spacing.xy(16, 0))
                                  ),
                                  onPressed: () {},
                                  child: Text("UPDATE",
                                      style: AppTheme.getTextStyle(
                                          themeData.textTheme.button,
                                          fontWeight: 600,
                                          color: themeData.colorScheme.onPrimary,letterSpacing: 0.3))),
                            ),
                          ],
                        ),
                      ),


                    ],
                  ),
                )));
  }
}
