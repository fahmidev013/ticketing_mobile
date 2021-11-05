
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile_ticketing/login.dart';
import 'package:mobile_ticketing/screens/HealthActivityScreen.dart';
import 'package:mobile_ticketing/screens/HealthHomeScreen.dart';
import 'package:mobile_ticketing/screens/HealthProfileScreen.dart';
import 'package:mobile_ticketing/screens/HealthScheduleScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AppTheme.dart';
import 'AppThemeNotifier.dart';
import 'model/Album.dart';
import 'package:http/http.dart' as http;

import 'model/User.dart';

Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<User> getUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String, dynamic> userMap = jsonDecode(prefs.getString('user')!);
  var user = User.fromJson(userMap);
  return user;
}

Future<void> logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("isLogin");
  prefs.remove("user");
  print(prefs.toString());
}



class Dashboard extends StatefulWidget  {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();

}

class _DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  TabController? _tabController;
  late CustomAppTheme customAppTheme;

  _handleTabSelection() {
    setState(() {
      _currentIndex = _tabController!.index;
    });
  }
  late Future<Album> futureAlbum;
  late Future<User> user;




  @override
  void initState() {
    _tabController = new TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController!.addListener(_handleTabSelection);
    _tabController!.animation!.addListener(() {
      final aniValue = _tabController!.animation!.value;
      if (aniValue - _currentIndex > 0.5) {
        setState(() {
          _currentIndex = _currentIndex + 1;
        });
      } else if (aniValue - _currentIndex < -0.5) {
        setState(() {
          _currentIndex = _currentIndex - 1;
        });
      }
    });
    super.initState();
    // futureAlbum = fetchAlbum();
    // user = getUser();
  }

  onTapped(value) {
    setState(() {
      _currentIndex = value;
    });
  }

  dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  late ThemeData themeData;

  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return Consumer<AppThemeNotifier>(
      builder: (BuildContext context, AppThemeNotifier value, Widget? child) {
        customAppTheme  = AppTheme.getCustomAppTheme(value.themeMode());
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.getThemeFromThemeMode(value.themeMode()),
          home: Scaffold(
            bottomNavigationBar: BottomAppBar(
                elevation: 0,
                shape: CircularNotchedRectangle(),
                child: Container(
                  decoration: BoxDecoration(
                    color: themeData.bottomAppBarTheme.color,
                    boxShadow: [
                      BoxShadow(
                        color: customAppTheme.shadowColor,
                        blurRadius: 3,
                        offset: Offset(0, -3),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: themeData.colorScheme.primary,
                    tabs: <Widget>[
                      Container(
                        child: (_currentIndex == 0)
                            ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              MdiIcons.home,
                              color: themeData.colorScheme.primary,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              decoration: BoxDecoration(
                                  color: themeData.primaryColor,
                                  borderRadius: new BorderRadius.all(
                                      Radius.circular(2.5))),
                              height: 5,
                              width: 5,
                            )
                          ],
                        )
                            : Icon(
                          MdiIcons.homeOutline,
                          color: themeData.colorScheme.onBackground,
                        ),
                      ),
                      Container(
                          child: (_currentIndex == 1)
                              ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                MdiIcons.runFast,
                                color: themeData.colorScheme.primary,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 4),
                                decoration: BoxDecoration(
                                    color: themeData.primaryColor,
                                    borderRadius: new BorderRadius.all(
                                        Radius.circular(2.5))),
                                height: 5,
                                width: 5,
                              )
                            ],
                          )
                              : Icon(
                            MdiIcons.runFast,
                            color: themeData.colorScheme.onBackground,
                          )),
                      Container(
                          child: (_currentIndex == 2)
                              ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                MdiIcons.calendar,
                                color: themeData.colorScheme.primary,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 4),
                                decoration: BoxDecoration(
                                    color: themeData.primaryColor,
                                    borderRadius: new BorderRadius.all(
                                        Radius.circular(2.5))),
                                height: 5,
                                width: 5,
                              )
                            ],
                          )
                              : Icon(
                            MdiIcons.calendarOutline,
                            color: themeData.colorScheme.onBackground,
                          )),
                      Container(
                          child: (_currentIndex == 3)
                              ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                MdiIcons.account,
                                color: themeData.colorScheme.primary,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 4),
                                decoration: BoxDecoration(
                                    color: themeData.primaryColor,
                                    borderRadius: new BorderRadius.all(
                                        Radius.circular(2.5))),
                                height: 5,
                                width: 5,
                              )
                            ],
                          )
                              : Icon(
                            MdiIcons.accountOutline,
                            color: themeData.colorScheme.onBackground,
                          )),
                    ],
                  ),
                )),
            body: TabBarView(
              controller: _tabController,
              children: <Widget>[
                HealthHomeScreen(),
                HealthActivityScreen(),
                HealthScheduleScreen(),
                HealthProfileScreen(),
              ],
            ),
          ),
        );
      },
    );
  }


  /*@override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<User>(
            future: user,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.name);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await logout();
            Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (_) => LoginPage(title: 'Login')));
          },
          tooltip: 'Increment Counter',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }*/
}