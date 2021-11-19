
import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile_ticketing/model/Issue.dart';
import 'package:mobile_ticketing/model/User.dart';
import 'package:mobile_ticketing/screens/LoginScreen.dart';
import 'package:mobile_ticketing/services/ApiServices.dart';
import 'package:mobile_ticketing/utils/SizeConfig.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../AppTheme.dart';
import '../AppThemeNotifier.dart';
import 'NotificationScreen.dart';
import 'ListIssueScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.rootContext, required this.user}) : super(key: key);

  final User? user;
  final BuildContext rootContext;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPreferences? prefs;
  late ThemeData themeData;
  late CustomAppTheme customAppTheme;
  final ApiService api = ApiService();
  late List<Issue> tickets;
  int? notifCount = 0;
  bool _isRunning = true;
  int? countOldId = 0;
  bool newComingNotif = false;
  bool isDone = false;



  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();


  Future<List<Issue>> _getIssueData() async {
    tickets = await api.getIssues(widget.user!.user_id);
    print("fetching jalan");
    return tickets;
  }

  /*Future<void> _getNotifikasi() async {
    List<int> count = await api.getNotif();
    if (count.first != countOldId){
      newComingNotif = true;
      countOldId = count.first;
      notifCount = count.length;
      notifClick = false;
    } else {
      newComingNotif = false;
    }
  }*/

Future<void> getSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs!.getBool('notif') == null) prefs!.setBool('notif', false);
}

  @override
  void initState() {
    super.initState();
    getSharedPref();
    int hitung = 0;
    Timer.periodic(Duration(seconds: 9), (Timer timer) {
      if (!_isRunning) {
        timer.cancel();
      }
      hitung++;
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text('Ambil data ke' + hitung.toString())));
      _getIssueData();
    });
    var initializationSettingsAndroid =
    AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOs);

    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);

    // _getIssueData();

  }


  void _showBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return Container(
            color: Colors.transparent,
            child: Container(
              decoration: new BoxDecoration(
                  color: themeData.backgroundColor,
                  borderRadius: new BorderRadius.only(
                      topLeft: Radius.circular(MySize.size16!),
                      topRight: Radius.circular(MySize.size16!))),
              child: Padding(
                padding: EdgeInsets.all(MySize.size16!),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          top: MySize.size8!, left: MySize.size8!),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: MySize.size40,
                            height: MySize.size40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  image: AssetImage(
                                      './assets/logo/logo.png'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: MySize.size16!),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.user!.user_name,
                                    style: themeData.textTheme.subtitle1!.merge(
                                        TextStyle(
                                            color: themeData
                                                .colorScheme.onBackground,
                                            letterSpacing: 0.3,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        widget.user!.user_email,
                                        style: themeData.textTheme.bodyText2!
                                            .merge(TextStyle(
                                            color: themeData
                                                .colorScheme.onBackground,
                                            letterSpacing: 0.3)),
                                      ),
                                      Icon(
                                        MdiIcons.chevronDown,
                                        size: 16,
                                        color:
                                        themeData.colorScheme.onBackground,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: themeData.dividerColor,
                    ),
                    /*ListTile(
                      dense: true,
                      leading: Icon(MdiIcons.bellRingOutline,
                          color: themeData.colorScheme.onBackground
                              .withAlpha(220)),
                      title: Text(
                        "Activity",
                        style: themeData.textTheme.bodyText1!.merge(TextStyle(
                            color: themeData.colorScheme.onBackground,
                            letterSpacing: 0.3,
                            fontWeight: FontWeight.w500)),
                      ),
                    ),
                    ListTile(
                      dense: true,
                      leading: Icon(MdiIcons.cogOutline,
                          color: themeData.colorScheme.onBackground
                              .withAlpha(220)),
                      title: Text(
                        "Settings",
                        style: themeData.textTheme.bodyText1!.merge(TextStyle(
                            color: themeData.colorScheme.onBackground,
                            letterSpacing: 0.3,
                            fontWeight: FontWeight.w500)),
                      ),
                    ),*/
                    ListTile(
                      onTap: () async {
                        await api.logout();
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                            LoginScreen()), (Route<dynamic> route) => false);
                      },
                      dense: true,
                      leading: Icon(MdiIcons.logout,
                          color: themeData.colorScheme.onBackground
                              .withAlpha(220)),
                      title: Text(
                        "Logout",
                        style: themeData.textTheme.bodyText1!.merge(TextStyle(
                            color: themeData.colorScheme.onBackground,
                            letterSpacing: 0.3,
                            fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }


  Future onSelectNotification(String payload) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return NotificationScreen();
    }));
    throw Exception("Error on server");
  }

  Future<void> showNotificationMediaStyle() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'media channel id',
      'media channel name',
      'media channel description',
      color: Colors.red,
      enableLights: true,
      largeIcon: DrawableResourceAndroidBitmap("mipmap/ic_launcher"),
      styleInformation: MediaStyleInformation(),
    );
    var platformChannelSpecifics =
    NotificationDetails(androidPlatformChannelSpecifics, null);
    await flutterLocalNotificationsPlugin.show(
        0, 'notification title', 'notification body', platformChannelSpecifics);
  }

  Future<void> showBigPictureNotification() async {
    var bigPictureStyleInformation = BigPictureStyleInformation(
        DrawableResourceAndroidBitmap("mipmap/ic_launcher"),
        largeIcon: DrawableResourceAndroidBitmap("mipmap/ic_launcher"),
        contentTitle: 'flutter devs',
        htmlFormatContentTitle: true,
        summaryText: 'summaryText',
        htmlFormatSummaryText: true);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'big text channel id',
        'big text channel name',
        'big text channel description',
        styleInformation: bigPictureStyleInformation);
    var platformChannelSpecifics =
    NotificationDetails(androidPlatformChannelSpecifics, null);
    await flutterLocalNotificationsPlugin.show(
        0, 'big text title', 'silent body', platformChannelSpecifics,
        payload: "big image notifications");
  }

  Future<void> scheduleNotification() async {
    var scheduledNotificationDateTime =
    DateTime.now().add(Duration(seconds: 5));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel id',
      'channel name',
      'channel description',
      icon: 'mipmap/ic_launcher',
      largeIcon: DrawableResourceAndroidBitmap('mipmap/ic_launcher'),
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'scheduled title',
        'scheduled body',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }

  Future<void> cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }

  showNotification() async {
    var android = new AndroidNotificationDetails(
        'id', 'channel ', 'description',
        priority: Priority.High, importance: Importance.Max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        0, 'Flutter devs', 'Flutter Local Notification Demo', platform,
        payload: 'Welcome to the Local Notification demo ');
  }

  Future<int?> _setNotif() async {
  bool? notifClick = prefs!.getBool('notif');
    if (!notifClick!)  notifCount = await api.getListNewNoString();
    else notifCount = 0;
    return notifCount;
  }

  Widget build(BuildContext context) {

    themeData = Theme.of(context);
    customAppTheme = AppTheme.getCustomAppTheme(1);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.getThemeFromThemeMode(1),
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
                color: customAppTheme.bgLayer2,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        padding: Spacing.vertical(16),
                        children: [
                          Container(
                            margin: Spacing.fromLTRB(24, 24, 24, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              _showBottomSheet(context);
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(MySize.size8!)),
                                              child: Image(
                                                image: AssetImage(
                                                    './assets/logo/app_logo.jpeg'),
                                                width: MySize.size44,
                                                height: MySize.size44,
                                              ),
                                            ),
                                          )

                                        ],
                                      ),
                                      SizedBox(width: 16),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap:() {
                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Proram bergenti')));
                                              setState(() {
                                                _isRunning = false;
                                              });
                                            } ,
                                            child: Text(
                                              widget.user!.user_name,
                                              style: AppTheme.getTextStyle(
                                                  themeData.textTheme.bodyText2,
                                                  color: themeData
                                                      .colorScheme.onBackground,
                                                  fontWeight: 600),
                                            ),
                                          ),
                                          Text(
                                            widget.user!.user_email,
                                            style: AppTheme.getTextStyle(
                                                themeData.textTheme.caption,
                                                color:
                                                themeData.colorScheme.primary,
                                                fontWeight: 500),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ),



                                // notifBuild(),
                                Container(
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              prefs!.setBool('notif', true);
                                              setState(() {
                                                notifCount = 0;
                                              });
                                              // await showNotification();
                                              Navigator.of(context).push(new MaterialPageRoute<Null>(
                                                  builder: (BuildContext context) {
                                                    return NotificationScreen();
                                                  },
                                                  fullscreenDialog: true));
                                            },
                                            child: Stack(
                                              clipBehavior: Clip.none,
                                              children: <Widget>[
                                                Icon(
                                                  FeatherIcons.bell,
                                                  size: 30,
                                                  color: AppTheme.theme.colorScheme.onBackground
                                                      .withAlpha(200),
                                                ),
                                                notifBuild(),
                                              ],
                                            ),
                                          )
                                        ]
                                    )
                                ),
                               /* Container(
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              // notifClick = true;
                                              // notifCount = 0;

                                              // await showNotification();
                                              Navigator.of(context).push(new MaterialPageRoute<Null>(
                                                  builder: (BuildContext context) {
                                                    return NotificationDialog();
                                                  },
                                                  fullscreenDialog: true));
                                            },
                                            child: Stack(
                                              clipBehavior: Clip.none,
                                              children: <Widget>[
                                                Icon(
                                                  FeatherIcons.bell,
                                                  size: 30,
                                                  color: AppTheme.theme.colorScheme.onBackground
                                                      .withAlpha(200),
                                                ),
                                                Positioned(
                                                  right: 0,
                                                  top: 0,
                                                  child: Container(
                                                    padding: Spacing.zero,
                                                    height: 18,
                                                    width: 18,
                                                    decoration: BoxDecoration(
                                                        color: themeData.colorScheme.primary,
                                                        borderRadius:
                                                        BorderRadius.all(Radius.circular(40))),
                                                    child: Center(
                                                      child: FxText.overline(
                                                        notifCount.toString(),
                                                        color: AppTheme.customTheme.groceryOnPrimary,
                                                        fontSize: 8,
                                                        fontWeight: 700,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ]
                                    )
                                ),*/
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MySize.size14,
                          ),
                          Container(
                            margin: Spacing.fromLTRB(24, 8, 24, 0),
                            child: Text('Mobile Helpdesk Ticket',
                              style: AppTheme.getTextStyle(
                                  themeData.textTheme.headline5,
                                  color:
                                  themeData.colorScheme.onBackground,
                                  letterSpacing: -0.4,
                                  fontWeight: 800),
                            )
                            /*TextFormField(
                              style: AppTheme.getTextStyle(
                                  themeData.textTheme.headline5,
                                  color: themeData.colorScheme.onBackground,
                                  letterSpacing: -0.4,
                                  fontWeight: 800),
                              decoration: InputDecoration(
                                fillColor: themeData.colorScheme.background,
                                hintStyle: AppTheme.getTextStyle(
                                    themeData.textTheme.headline5,
                                    color:
                                    themeData.colorScheme.onBackground,
                                    letterSpacing: -0.4,
                                    fontWeight: 800),
                                filled: false,
                                hintText: "Mobile Helpdesk Ticket",
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                              autocorrect: false,

                              textCapitalization:
                              TextCapitalization.sentences,
                            ),*/
                          ),
                          SizedBox(
                            height: MySize.size14,
                          ),
                          Container(
                            margin: Spacing.fromLTRB(24, 0, 24, 0),
                            child: Text('Trouble ticket mobile application is a supporting system that developed by Directorat Pengendalian SDPPI that have a function for compiles all trouble tickets to make it easier for SIMS infrastructure users to view and track the ticket status by notifications that can be access from anywhere.',
                            style: AppTheme.getTextStyle(
                                themeData.textTheme.bodyText2,
                                color: themeData.colorScheme.onBackground,
                                fontWeight: 600,
                                letterSpacing: 0,
                                muted: true),
                            )
                            /*TextFormField(
                              style: AppTheme.getTextStyle(
                                  themeData.textTheme.bodyText2,
                                  color: themeData.colorScheme.onBackground,
                                  fontWeight: 500,
                                  letterSpacing: 0,
                                  muted: true),
                              decoration: InputDecoration(
                                hintText: "Trouble ticket mobile application is a supporting system that developed by Directorat Pengendalian SDPPI that have a function for compiles all trouble tickets to make it easier for SIMS infrastructure users to view and track the ticket status by notifications that can be access from anywhere.",
                                hintStyle: AppTheme.getTextStyle(
                                    themeData.textTheme.bodyText2,
                                    color:
                                    themeData.colorScheme.onBackground,
                                    fontWeight: 600,
                                    letterSpacing: 0,
                                    xMuted: true),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.5,
                                      color: themeData
                                          .colorScheme.onBackground
                                          .withAlpha(50)),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.4,
                                      color: themeData
                                          .colorScheme.onBackground
                                          .withAlpha(50)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.5,
                                      color: themeData
                                          .colorScheme.onBackground
                                          .withAlpha(50)),
                                ),
                              ),
                              maxLines: 6,
                              minLines: 1,
                              autofocus: false,
                              textCapitalization:
                              TextCapitalization.sentences,
                            ),*/
                          ),
                          // locationWidget(),
                          // eventTypeWidget(),
                          inviteWidget()
                        ],
                      ),
                    ),
                    /*Container(
                      color: customAppTheme.bgLayer1,
                      padding: Spacing.fromLTRB(24, 16, 24, 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "\$99",
                                  style: AppTheme.getTextStyle(
                                      themeData.textTheme.bodyText1,
                                      fontWeight: 700,
                                      letterSpacing: 0,
                                      color: themeData
                                          .colorScheme.primary)),
                              TextSpan(
                                  text: " /per person",
                                  style: AppTheme.getTextStyle(
                                    themeData.textTheme.caption,
                                    fontWeight: 600,
                                    letterSpacing: 0,
                                    color: themeData
                                        .colorScheme.onBackground,)),
                            ]),
                          ),
                          Container(
                            padding: Spacing.fromLTRB(8, 8, 8, 8),
                            decoration: BoxDecoration(
                                color: themeData.colorScheme.primary,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(MySize.size40!))),
                            child: Row(
                              children: [
                                Container(
                                  margin: Spacing.left(12),
                                  child: Text(
                                    "Create".toUpperCase(),
                                    style: AppTheme.getTextStyle(
                                        themeData.textTheme.caption,
                                        fontSize: 12,
                                        letterSpacing: 0.7,
                                        color:
                                        themeData.colorScheme.onPrimary,
                                        fontWeight: 600),
                                  ),
                                ),
                                Container(
                                  margin: Spacing.left(16),
                                  padding: Spacing.all(4),
                                  decoration: BoxDecoration(
                                      color:
                                      themeData.colorScheme.onPrimary,
                                      shape: BoxShape.circle),
                                  child: Icon(
                                    MdiIcons.chevronRight,
                                    size: MySize.size20,
                                    color: themeData.colorScheme.primary,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )*/
                  ],
                ))));
  }

  Widget notifBuild() {
    return FutureBuilder<int?>(
        future: Future.delayed(const Duration(seconds: 5), () => _setNotif()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if( snapshot.connectionState == ConnectionState.waiting){
            return  Center(child: SizedBox());
          }
          else{
            if (snapshot.hasError){
              print('${snapshot.error}');
              return Center(child: Container());
            } else {
              notifCount = snapshot.data;
              print('TESS' + notifCount.toString());
              return notifCount != 0 ? Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: Spacing.zero,
                  height: 18,
                  width: 18,
                  decoration: BoxDecoration(
                      color: themeData.colorScheme.primary,
                      borderRadius:
                      BorderRadius.all(Radius.circular(40))),
                  child: Center(
                    child: FxText.overline(
                      notifCount.toString(),
                      color: AppTheme.customTheme.groceryOnPrimary,
                      fontSize: 8,
                      fontWeight: 700,
                    ),
                  ),
                ),
              ) : Container();
            }
          }
        });
  }

  Widget inviteWidget() {
    List<Issue>? ticketsOpen;
    List<Issue>? ticketsSubmitted;
    List<Issue>? ticketsReview;
    List<Issue>? ticketsPending;
    List<Issue>? ticketsCustTest;
    List<Issue>? ticketsLS;
    List<Issue>? ticketsResolved;
    List<Issue>? ticketsReopen;
    List<Issue>? ticketsClosed;
    List<Issue>? ticketsArchive;
    List<Issue>? ticketsTodo;
    List<Issue>? ticketsDone;
    return  FutureBuilder(
        future: _getIssueData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if( snapshot.connectionState == ConnectionState.waiting){
            return  Center(child: Text('Please wait its loading...'));
          }else{
            if (snapshot.hasError)
              return Center(child: Text('Error: ${snapshot.error}'));
            else
              ticketsOpen = [];
            ticketsSubmitted = [];
            ticketsReview = [];
             ticketsPending = [];
             ticketsCustTest =[];
             ticketsLS =[];
            ticketsResolved=[];
            ticketsReopen=[];
            ticketsClosed=[];
            ticketsArchive=[];
            ticketsTodo=[];
            ticketsDone=[];
              for (Issue val in snapshot.data){
                if (val.issue_status == 'OPEN') ticketsOpen!.add(val);
                if (val.issue_status == 'SUBMITTED') ticketsSubmitted!.add(val);
                if (val.issue_status == 'NEEDS REVIEW') ticketsReview!.add(val);
                if (val.issue_status == 'PENDING') ticketsPending!.add(val);
                if (val.issue_status == 'CUSTOMER TESTING') ticketsCustTest!.add(val);
                if (val.issue_status == 'LS ACTION') ticketsLS!.add(val);
                if (val.issue_status == 'RESOLVED') ticketsResolved!.add(val);
                if (val.issue_status == 'REOPENED') ticketsReopen!.add(val);
                if (val.issue_status == 'CLOSED') ticketsClosed!.add(val);
                if (val.issue_status == 'ARCHIVED') ticketsArchive!.add(val);
                if (val.issue_status == 'TO DO') ticketsTodo!.add(val);
                if (val.issue_status == 'DONE') ticketsDone!.add(val);
              }
              // return Center(child: new Text('${snapshot.data[1].issue_title}'));  // snapshot.data  :- get your object which is pass from your downloadData() function
              return Container(
                margin: Spacing.fromLTRB(24, 24, 24, 0),
                padding: Spacing.all(16),
                decoration: BoxDecoration(
                    color: customAppTheme.bgLayer1,
                    border: Border.all(color: customAppTheme.bgLayer3, width: 1),

                    borderRadius: BorderRadius.all(Radius.circular(MySize.size8!))),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Kategori Status Tiket",
                          style: AppTheme.getTextStyle(themeData.textTheme.bodyText2,
                              color: themeData.colorScheme.onBackground, fontWeight: 600),
                        )
                      ],
                    ),

                    Container(
                      margin: Spacing.top(12),
                      child: Material(
                        child: InkWell(
                          splashColor: customAppTheme.shimmerHighlightColor,
                          onTap: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => ListIssueScreen(issue: ticketsOpen, title: 'OPEN TICKET',)));
                          }, // Handle your callback
                          child: Row(
                            children: [
                              Container(
                                  width: MySize.size38,
                                  height: MySize.size38,
                                  decoration: BoxDecoration(
                                      color: themeData.colorScheme.primary.withAlpha(32),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(MySize.size8!))),
                                  child: Center(
                                    child: Text(
                                      '${ticketsOpen?.length ?? 0}',
                                      style: AppTheme.getTextStyle(
                                          themeData.textTheme.bodyText2,
                                          color: themeData.colorScheme.primary,
                                          fontWeight: 800),
                                    ),
                                  )),
                              Expanded(
                                child: Container(
                                  margin: Spacing.left(16),
                                  child: Text(
                                    "Open",
                                    style: AppTheme.getTextStyle(
                                        themeData.textTheme.bodyText2,
                                        fontWeight: 600,
                                        color: themeData.colorScheme.onBackground
                                            .withAlpha(220)),
                                  ),
                                ),
                              ),
                              Container(
                                child: Icon(
                                  MdiIcons.chevronRight,
                                  size: MySize.size20,
                                  color: themeData.colorScheme.onBackground.withAlpha(200),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    Container(
                      margin: Spacing.top(12),
                      child: Material(
                          child: InkWell(
                            splashColor: customAppTheme.shimmerHighlightColor,
                            onTap: () {
                              print("Container clicked");
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => ListIssueScreen(issue: ticketsPending, title: 'PENDING TICKET',)));
                            }, // Handle your callback
                            child: Row(
                              children: [
                                Container(
                                    width: MySize.size38,
                                    height: MySize.size38,
                                    decoration: BoxDecoration(
                                        color: themeData.colorScheme.primary.withAlpha(32),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(MySize.size8!))),
                                    child: Center(
                                      child: Text(
                                        '${ticketsPending?.length ?? 0}',
                                        style: AppTheme.getTextStyle(
                                            themeData.textTheme.bodyText2,
                                            color: themeData.colorScheme.primary,
                                            fontWeight: 800),
                                      ),
                                    )),
                                Expanded(
                                  child: Container(
                                    margin: Spacing.left(16),
                                    child: Text(
                                      "Pending",
                                      style: AppTheme.getTextStyle(
                                          themeData.textTheme.bodyText2,
                                          fontWeight: 600,
                                          color: themeData.colorScheme.onBackground
                                              .withAlpha(220)),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Icon(
                                    MdiIcons.chevronRight,
                                    size: MySize.size20,
                                    color: themeData.colorScheme.onBackground.withAlpha(200),
                                  ),
                                )
                              ],
                            ),



                          )),),

                    Container(
                      margin: Spacing.top(12),
                      child: Material(
                          child: InkWell(
                            splashColor: customAppTheme.shimmerHighlightColor,
                            onTap: () {
                              print("Container clicked");
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => ListIssueScreen(issue: ticketsLS, title: 'LS ACTION TICKET',)));
                            }, // Handle your callback
                            child: Row(
                              children: [
                                Container(
                                    width: MySize.size38,
                                    height: MySize.size38,
                                    decoration: BoxDecoration(
                                        color: themeData.colorScheme.primary.withAlpha(32),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(MySize.size8!))),
                                    child: Center(
                                      child: Text(
                                        '${ticketsLS?.length ?? 0}',
                                        style: AppTheme.getTextStyle(
                                            themeData.textTheme.bodyText2,
                                            color: themeData.colorScheme.primary,
                                            fontWeight: 800),
                                      ),
                                    )),
                                Expanded(
                                  child: Container(
                                    margin: Spacing.left(16),
                                    child: Text(
                                      "LS Action",
                                      style: AppTheme.getTextStyle(
                                          themeData.textTheme.bodyText2,
                                          fontWeight: 600,
                                          color: themeData.colorScheme.onBackground
                                              .withAlpha(220)),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Icon(
                                    MdiIcons.chevronRight,
                                    size: MySize.size20,
                                    color: themeData.colorScheme.onBackground.withAlpha(200),
                                  ),
                                )
                              ],
                            ),



                          )),),

                    Container(
                      margin: Spacing.top(12),
                      child: Material(
                          child: InkWell(
                            splashColor: customAppTheme.shimmerHighlightColor,
                            onTap: () {
                              print("Container clicked");
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => ListIssueScreen(issue: ticketsClosed, title: 'CLOSED TICKET',)));
                            }, // Handle your callback
                            child: Row(
                              children: [
                                Container(
                                    width: MySize.size38,
                                    height: MySize.size38,
                                    decoration: BoxDecoration(
                                        color: themeData.colorScheme.primary.withAlpha(32),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(MySize.size8!))),
                                    child: Center(
                                      child: Text(
                                        '${ticketsClosed?.length ?? 0}',
                                        style: AppTheme.getTextStyle(
                                            themeData.textTheme.bodyText2,
                                            color: themeData.colorScheme.primary,
                                            fontWeight: 800),
                                      ),
                                    )),
                                Expanded(
                                  child: Container(
                                    margin: Spacing.left(16),
                                    child: Text(
                                      "Closed",
                                      style: AppTheme.getTextStyle(
                                          themeData.textTheme.bodyText2,
                                          fontWeight: 600,
                                          color: themeData.colorScheme.onBackground
                                              .withAlpha(220)),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Icon(
                                    MdiIcons.chevronRight,
                                    size: MySize.size20,
                                    color: themeData.colorScheme.onBackground.withAlpha(200),
                                  ),
                                )
                              ],
                            ),



                          )),),
                    //-------------------------------
                        Container(
                        margin: Spacing.top(12),
          child: Material(
                        child: InkWell(
          splashColor: customAppTheme.shimmerHighlightColor,
                          onTap: () {
                            print("Container clicked");
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => ListIssueScreen(issue: ticketsSubmitted, title: 'SUBMIT TICKET',)));
                          }, // Handle your callback
                          child:  Row(
                              children: [
                                Container(
                                    width: MySize.size38,
                                    height: MySize.size38,
                                    decoration: BoxDecoration(
                                        color: themeData.colorScheme.primary.withAlpha(32),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(MySize.size8!))),
                                    child: Center(
                                      child: Text(
                                        '${ticketsSubmitted?.length ?? 0}',
                                        style: AppTheme.getTextStyle(
                                            themeData.textTheme.bodyText2,
                                            color: themeData.colorScheme.primary,
                                            fontWeight: 800),
                                      ),
                                    )),
                                Expanded(
                                  child: Container(
                                    margin: Spacing.left(16),
                                    child: Text(
                                      "Submitted",
                                      style: AppTheme.getTextStyle(
                                          themeData.textTheme.bodyText2,
                                          fontWeight: 600,
                                          color: themeData.colorScheme.onBackground
                                              .withAlpha(220)),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Icon(
                                    MdiIcons.chevronRight,
                                    size: MySize.size20,
                                    color: themeData.colorScheme.onBackground.withAlpha(200),
                                  ),
                                )
                              ],
                            ),



                        )),
                        ),

                    //-------------------------------

          Container(
          margin: Spacing.top(12),
          child: Material(
                        child: InkWell(
                          splashColor: customAppTheme.shimmerHighlightColor,
                          onTap: () {
                            print("Container clicked");
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => ListIssueScreen(issue: ticketsReview, title: 'REVIEW TICKET',)));
                          }, // Handle your callback
                          child: Row(
                              children: [
                                Container(
                                    width: MySize.size38,
                                    height: MySize.size38,
                                    decoration: BoxDecoration(
                                        color: themeData.colorScheme.primary.withAlpha(32),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(MySize.size8!))),
                                    child: Center(
                                      child: Text(
                                        '${ticketsReview?.length ?? 0}',
                                        style: AppTheme.getTextStyle(
                                            themeData.textTheme.bodyText2,
                                            color: themeData.colorScheme.primary,
                                            fontWeight: 800),
                                      ),
                                    )),
                                Expanded(
                                  child: Container(
                                    margin: Spacing.left(16),
                                    child: Text(
                                      "Need Review",
                                      style: AppTheme.getTextStyle(
                                          themeData.textTheme.bodyText2,
                                          fontWeight: 600,
                                          color: themeData.colorScheme.onBackground
                                              .withAlpha(220)),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Icon(
                                    MdiIcons.chevronRight,
                                    size: MySize.size20,
                                    color: themeData.colorScheme.onBackground.withAlpha(200),
                                  ),
                                )
                              ],
                            ),



                        )),
          ),

                    //-------------------------------


                    //-------------------------------
          Container(
          margin: Spacing.top(12),
          child: Material(
                        child: InkWell(
                          splashColor: customAppTheme.shimmerHighlightColor,
                          onTap: () {
                            print("Container clicked");
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => ListIssueScreen(issue: ticketsCustTest, title: 'CUSTOMER TESTING TICKET',)));
                          }, // Handle your callback
                          child: Row(
                              children: [
                                Container(
                                    width: MySize.size38,
                                    height: MySize.size38,
                                    decoration: BoxDecoration(
                                        color: themeData.colorScheme.primary.withAlpha(32),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(MySize.size8!))),
                                    child: Center(
                                      child: Text(
                                        '${ticketsCustTest?.length ?? 0}',
                                        style: AppTheme.getTextStyle(
                                            themeData.textTheme.bodyText2,
                                            color: themeData.colorScheme.primary,
                                            fontWeight: 800),
                                      ),
                                    )),
                                Expanded(
                                  child: Container(
                                    margin: Spacing.left(16),
                                    child: Text(
                                      "Customer Testing",
                                      style: AppTheme.getTextStyle(
                                          themeData.textTheme.bodyText2,
                                          fontWeight: 600,
                                          color: themeData.colorScheme.onBackground
                                              .withAlpha(220)),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Icon(
                                    MdiIcons.chevronRight,
                                    size: MySize.size20,
                                    color: themeData.colorScheme.onBackground.withAlpha(200),
                                  ),
                                )
                              ],
                            ),



                        )),),

                    //-------------------------------


                    //-------------------------------
          Container(
          margin: Spacing.top(12),
          child: Material(
                        child: InkWell(
                          splashColor: customAppTheme.shimmerHighlightColor,
                          onTap: () {
                            print("Container clicked");
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => ListIssueScreen(issue: ticketsResolved, title: 'RESOLVED TICKET',)));
                          }, // Handle your callback
                          child: Row(
                              children: [
                                Container(
                                    width: MySize.size38,
                                    height: MySize.size38,
                                    decoration: BoxDecoration(
                                        color: themeData.colorScheme.primary.withAlpha(32),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(MySize.size8!))),
                                    child: Center(
                                      child: Text(
                                        '${ticketsResolved?.length ?? 0}',
                                        style: AppTheme.getTextStyle(
                                            themeData.textTheme.bodyText2,
                                            color: themeData.colorScheme.primary,
                                            fontWeight: 800),
                                      ),
                                    )),
                                Expanded(
                                  child: Container(
                                    margin: Spacing.left(16),
                                    child: Text(
                                      "Resolved",
                                      style: AppTheme.getTextStyle(
                                          themeData.textTheme.bodyText2,
                                          fontWeight: 600,
                                          color: themeData.colorScheme.onBackground
                                              .withAlpha(220)),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Icon(
                                    MdiIcons.chevronRight,
                                    size: MySize.size20,
                                    color: themeData.colorScheme.onBackground.withAlpha(200),
                                  ),
                                )
                              ],
                            ),



                        )),),

                    //-------------------------------
          Container(
          margin: Spacing.top(12),
          child: Material(
                        child: InkWell(
                          splashColor: customAppTheme.shimmerHighlightColor,
                          onTap: () {
                            print("Container clicked");
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => ListIssueScreen(issue: ticketsReopen, title: 'REOPEN TICKET',)));
                          }, // Handle your callback
                          child: Row(
                              children: [
                                Container(
                                    width: MySize.size38,
                                    height: MySize.size38,
                                    decoration: BoxDecoration(
                                        color: themeData.colorScheme.primary.withAlpha(32),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(MySize.size8!))),
                                    child: Center(
                                      child: Text(
                                        '${ticketsReopen?.length ?? 0}',
                                        style: AppTheme.getTextStyle(
                                            themeData.textTheme.bodyText2,
                                            color: themeData.colorScheme.primary,
                                            fontWeight: 800),
                                      ),
                                    )),
                                Expanded(
                                  child: Container(
                                    margin: Spacing.left(16),
                                    child: Text(
                                      "Reopened",
                                      style: AppTheme.getTextStyle(
                                          themeData.textTheme.bodyText2,
                                          fontWeight: 600,
                                          color: themeData.colorScheme.onBackground
                                              .withAlpha(220)),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Icon(
                                    MdiIcons.chevronRight,
                                    size: MySize.size20,
                                    color: themeData.colorScheme.onBackground.withAlpha(200),
                                  ),
                                )
                              ],
                            ),



                        )),),









                    //-------------------------------

                    //-------------------------------
          Container(
          margin: Spacing.top(12),
          child: Material(
                        child: InkWell(
                          splashColor: customAppTheme.shimmerHighlightColor,
                          onTap: () {
                            print("Container clicked");
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => ListIssueScreen(issue: ticketsArchive, title: 'ARCHIEVED TICKET',)));
                          }, // Handle your callback
                          child: Row(
                              children: [
                                Container(
                                    width: MySize.size38,
                                    height: MySize.size38,
                                    decoration: BoxDecoration(
                                        color: themeData.colorScheme.primary.withAlpha(32),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(MySize.size8!))),
                                    child: Center(
                                      child: Text(
                                        '${ticketsArchive?.length ?? 0}',
                                        style: AppTheme.getTextStyle(
                                            themeData.textTheme.bodyText2,
                                            color: themeData.colorScheme.primary,
                                            fontWeight: 800),
                                      ),
                                    )),
                                Expanded(
                                  child: Container(
                                    margin: Spacing.left(16),
                                    child: Text(
                                      "Archieved",
                                      style: AppTheme.getTextStyle(
                                          themeData.textTheme.bodyText2,
                                          fontWeight: 600,
                                          color: themeData.colorScheme.onBackground
                                              .withAlpha(220)),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Icon(
                                    MdiIcons.chevronRight,
                                    size: MySize.size20,
                                    color: themeData.colorScheme.onBackground.withAlpha(200),
                                  ),
                                )
                              ],
                            ),


                        )),),

                    //-------------------------------
          Container(
          margin: Spacing.top(12),
          child: Material(
                        child: InkWell(
                          splashColor: customAppTheme.shimmerHighlightColor,
                          onTap: () {
                            print("Container clicked");
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => ListIssueScreen(issue: ticketsTodo, title: 'TODO TICKET',)));
                          }, // Handle your callback
                          child: Row(
                              children: [
                                Container(
                                    width: MySize.size38,
                                    height: MySize.size38,
                                    decoration: BoxDecoration(
                                        color: themeData.colorScheme.primary.withAlpha(32),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(MySize.size8!))),
                                    child: Center(
                                      child: Text(
                                        '${ticketsTodo?.length ?? 0}',
                                        style: AppTheme.getTextStyle(
                                            themeData.textTheme.bodyText2,
                                            color: themeData.colorScheme.primary,
                                            fontWeight: 800),
                                      ),
                                    )),
                                Expanded(
                                  child: Container(
                                    margin: Spacing.left(16),
                                    child: Text(
                                      "To Do",
                                      style: AppTheme.getTextStyle(
                                          themeData.textTheme.bodyText2,
                                          fontWeight: 600,
                                          color: themeData.colorScheme.onBackground
                                              .withAlpha(220)),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Icon(
                                    MdiIcons.chevronRight,
                                    size: MySize.size20,
                                    color: themeData.colorScheme.onBackground.withAlpha(200),
                                  ),
                                )
                              ],
                            ),



                        )),),

                    //-------------------------------
          Container(
          margin: Spacing.top(12),
          child: Material(
                        child: InkWell(
                          splashColor: customAppTheme.shimmerHighlightColor,
                          onTap: () {
                            print("Container clicked");
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => ListIssueScreen(issue: ticketsDone, title: 'DONE TICKETS',)));
                          }, // Handle your callback
                          child: Row(
                              children: [
                                Container(
                                    width: MySize.size38,
                                    height: MySize.size38,
                                    decoration: BoxDecoration(
                                        color: themeData.colorScheme.primary.withAlpha(32),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(MySize.size8!))),
                                    child: Center(
                                      child: Text(
                                        '${ticketsDone?.length ?? 0}',
                                        style: AppTheme.getTextStyle(
                                            themeData.textTheme.bodyText2,
                                            color: themeData.colorScheme.primary,
                                            fontWeight: 800),
                                      ),
                                    )),
                                Expanded(
                                  child: Container(
                                    margin: Spacing.left(16),
                                    child: Text(
                                      "Done",
                                      style: AppTheme.getTextStyle(
                                          themeData.textTheme.bodyText2,
                                          fontWeight: 600,
                                          color: themeData.colorScheme.onBackground
                                              .withAlpha(220)),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Icon(
                                    MdiIcons.chevronRight,
                                    size: MySize.size20,
                                    color: themeData.colorScheme.onBackground.withAlpha(200),
                                  ),
                                )
                              ],
                            ),



                        )),),

                  ],
                ),
              )   ;
          };
        },

    ) ;
  }


  Widget singleFriend({required String image, required String name, required bool isSelected}) {
    return Container(
      child: Row(
        children: [
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(MySize.size8!)),
              child: Image(
                image: AssetImage(image),
                width: MySize.size38,
                height: MySize.size38,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: Spacing.left(16),
              child: Text(
                name,
                style: AppTheme.getTextStyle(themeData.textTheme.bodyText2,
                    fontWeight: 600,
                    color: isSelected
                        ? customAppTheme.colorSuccess.withAlpha(220)
                        : themeData.colorScheme.onBackground.withAlpha(180)),
              ),
            ),
          ),
          Container(
            child: Icon(
              MdiIcons.check,
              size: MySize.size20,
              color: isSelected
                  ? customAppTheme.colorSuccess.withAlpha(240)
                  : themeData.colorScheme.onBackground.withAlpha(100),
            ),
          )
        ],
      ),
    );
  }


}
