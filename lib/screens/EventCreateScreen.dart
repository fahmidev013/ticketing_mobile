
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile_ticketing/model/Issue.dart';
import 'package:mobile_ticketing/services/api_service.dart';
import 'package:mobile_ticketing/utils/SizeConfig.dart';
import 'package:provider/provider.dart';
import '../../AppTheme.dart';
import '../AppThemeNotifier.dart';

class EventCreateScreen extends StatefulWidget {
  @override
  _EventCreateScreenState createState() => _EventCreateScreenState();
}

class _EventCreateScreenState extends State<EventCreateScreen> {
  late ThemeData themeData;
  late CustomAppTheme customAppTheme;
  final ApiService api = ApiService();
  late List<Issue> tickets;
  bool isDone = false;



  List<String> _simpleChoice = ["Change place", "Add another", "Remove"];
  bool _switch = true;

  Future<List<Issue>> _getIssueData() async {
    tickets = await api.getIssues();
    return tickets;
  }


  @override
  void initState() {
    super.initState();
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
                              children: [
                                Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(MySize.size8!)),
                                    child: Image(
                                      image: AssetImage(
                                          './assets/images/avatar-4.jpg'),
                                      width: MySize.size44,
                                      height: MySize.size44,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: Spacing.left(16),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Becky Parra",
                                        style: AppTheme.getTextStyle(
                                            themeData.textTheme.bodyText2,
                                            color: themeData
                                                .colorScheme.onBackground,
                                            fontWeight: 600),
                                      ),
                                      Text(
                                        "Email at gmail.com",
                                        style: AppTheme.getTextStyle(
                                            themeData.textTheme.caption,
                                            color:
                                            customAppTheme.colorSuccess,
                                            fontWeight: 500),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: Spacing.fromLTRB(24, 8, 24, 0),
                            child: TextFormField(
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
                            ),
                          ),
                          Container(
                            margin: Spacing.fromLTRB(24, 0, 24, 0),
                            child: TextFormField(
                              style: AppTheme.getTextStyle(
                                  themeData.textTheme.bodyText2,
                                  color: themeData.colorScheme.onBackground,
                                  fontWeight: 500,
                                  letterSpacing: 0,
                                  muted: true),
                              decoration: InputDecoration(
                                hintText: "Aplikasi untuk lorem ipsume Aplikasi untuk lorem ipsume Aplikasi untuk lorem ipsume Aplikasi untuk lorem ipsume Aplikasi untuk lorem ipsume Aplikasi untuk lorem ipsume",
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
                            ),
                          ),
                          // locationWidget(),
                          // eventTypeWidget(),
                          inviteWidget()
                        ],
                      ),
                    ),
                    Container(
                      color: customAppTheme.bgLayer1,
                      padding: Spacing.fromLTRB(24, 16, 24, 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    )
                  ],
                ))));
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
                    //-------------------------------
                    Container(
                      margin: Spacing.top(12),
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
                    ),
                    //-------------------------------
                    Container(
                      margin: Spacing.top(12),
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
                                "Needs Review",
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
                    //-------------------------------
                    Container(
                      margin: Spacing.top(12),
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
                    ),
                    //-------------------------------
                    Container(
                      margin: Spacing.top(12),
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
                    ),
                    //-------------------------------
                    Container(
                      margin: Spacing.top(12),
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
                    ),
                    //-------------------------------
                    Container(
                      margin: Spacing.top(12),
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
                    ),
                    //-------------------------------
                    Container(
                      margin: Spacing.top(12),
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
                    ),
                    //-------------------------------
                    Container(
                      margin: Spacing.top(12),
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
                    ),
                    //-------------------------------
                    Container(
                      margin: Spacing.top(12),
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
                                "Archived",
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
                    //-------------------------------
                    Container(
                      margin: Spacing.top(12),
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
                    ),
                    //-------------------------------
                    Container(
                      margin: Spacing.top(12),
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
                    ),
                  ],
                ),
              )   ;
          };
        },

    ) ;
  }


  /*Widget build(BuildContext context) {
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
                                  children: [
                                    Container(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(MySize.size8!)),
                                        child: Image(
                                          image: AssetImage(
                                              './assets/images/avatar-4.jpg'),
                                          width: MySize.size44,
                                          height: MySize.size44,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: Spacing.left(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Becky Parra",
                                            style: AppTheme.getTextStyle(
                                                themeData.textTheme.bodyText2,
                                                color: themeData
                                                    .colorScheme.onBackground,
                                                fontWeight: 600),
                                          ),
                                          Text(
                                            "Email at gmail.com",
                                            style: AppTheme.getTextStyle(
                                                themeData.textTheme.caption,
                                                color:
                                                    customAppTheme.colorSuccess,
                                                fontWeight: 500),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: Spacing.fromLTRB(24, 8, 24, 0),
                                child: TextFormField(
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
                                ),
                              ),
                              Container(
                                margin: Spacing.fromLTRB(24, 0, 24, 0),
                                child: TextFormField(
                                  style: AppTheme.getTextStyle(
                                      themeData.textTheme.bodyText2,
                                      color: themeData.colorScheme.onBackground,
                                      fontWeight: 500,
                                      letterSpacing: 0,
                                      muted: true),
                                  decoration: InputDecoration(
                                    hintText: "Aplikasi untuk lorem ipsume Aplikasi untuk lorem ipsume Aplikasi untuk lorem ipsume Aplikasi untuk lorem ipsume Aplikasi untuk lorem ipsume Aplikasi untuk lorem ipsume",
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
                                ),
                              ),
                              // locationWidget(),
                              // eventTypeWidget(),
                              inviteWidget()
                            ],
                          ),
                        ),
                        Container(
                          color: customAppTheme.bgLayer1,
                          padding: Spacing.fromLTRB(24, 16, 24, 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        )
                      ],
                    ))));

  }*/

  Widget locationWidget() {
    return Container(
      margin: Spacing.fromLTRB(24, 24, 24, 0),
      decoration: BoxDecoration(
          color: customAppTheme.bgLayer1,
          border: Border.all(color: customAppTheme.bgLayer3, width: 1),

          borderRadius: BorderRadius.all(Radius.circular(MySize.size8!))),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(MySize.size8!),
                bottomLeft: Radius.circular(MySize.size8!)),
            child: Image(
              image: AssetImage('./assets/design/pattern-1.png'),
              height: MySize.size72,
              width: MySize.size80,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              margin: Spacing.left(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Flutter Academy",
                    style: AppTheme.getTextStyle(themeData.textTheme.subtitle2,
                        fontWeight: 600,
                        color: themeData.colorScheme.onBackground),
                  ),
                  Container(
                    margin: Spacing.top(2),
                    child: Text(
                      "8:00 - 11:00 AM",
                      style: AppTheme.getTextStyle(themeData.textTheme.caption,
                          fontSize: 12,
                          fontWeight: 600,
                          color: themeData.colorScheme.onBackground,
                          xMuted: true),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            child: PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return _simpleChoice.map((String choice) {
                  return PopupMenuItem(
                    height: 36,
                    value: choice,
                    child: Text(choice,
                        style: AppTheme.getTextStyle(
                          themeData.textTheme.bodyText2,
                          color: themeData.colorScheme.onBackground,
                        )),
                  );
                }).toList();
              },
              color: customAppTheme.bgLayer1,
              icon: Icon(
                MdiIcons.chevronDown,
                color: themeData.colorScheme.onBackground,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget eventTypeWidget() {
    return Container(
      margin: Spacing.fromLTRB(24, 24, 24, 0),
      padding: Spacing.fromLTRB(16, 16, 8, 16),
      decoration: BoxDecoration(
          color: customAppTheme.bgLayer1,
          border: Border.all(color: customAppTheme.bgLayer3, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(MySize.size8!))),
      child: Row(
        children: [
          Expanded(
              child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Public event",
                  style: AppTheme.getTextStyle(themeData.textTheme.bodyText1,
                      color: themeData.colorScheme.onBackground,
                      fontWeight: 600),
                ),
                Container(
                  margin: Spacing.top(2),
                  child: Text(
                    "Add event to the public feed",
                    style: AppTheme.getTextStyle(themeData.textTheme.caption,
                        color: themeData.colorScheme.onBackground,
                        fontWeight: 600,
                        xMuted: true),
                  ),
                ),
              ],
            ),
          )),
          Container(
            child: Switch(
              onChanged: (bool value) {
                setState(() {
                  _switch = value;
                });
              },
              value: _switch,
              activeColor: themeData.colorScheme.primary,
            ),
          )
        ],
      ),
    );
  }

  /*Widget inviteWidget() {
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
                        ticketsOpen!.length.toString(),
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
          //-------------------------------
          Container(
            margin: Spacing.top(12),
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
                        "48",
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
          ),
          //-------------------------------
          Container(
            margin: Spacing.top(12),
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
                        "48",
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
                      "Needs Review",
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
          //-------------------------------
          Container(
            margin: Spacing.top(12),
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
                        "48",
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
          ),
          //-------------------------------
          Container(
            margin: Spacing.top(12),
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
                        "48",
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
          ),
          //-------------------------------
          Container(
            margin: Spacing.top(12),
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
                        "48",
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
          ),
          //-------------------------------
          Container(
            margin: Spacing.top(12),
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
                        "48",
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
          ),
          //-------------------------------
          Container(
            margin: Spacing.top(12),
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
                        "48",
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
          ),
          //-------------------------------
          Container(
            margin: Spacing.top(12),
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
                        "48",
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
          ),
          //-------------------------------
          Container(
            margin: Spacing.top(12),
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
                        "48",
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
                      "Archived",
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
          //-------------------------------
          Container(
            margin: Spacing.top(12),
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
                        "48",
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
          ),
          //-------------------------------
          Container(
            margin: Spacing.top(12),
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
                        "48",
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
          ),
        ],
      ),
    )  ;
  }*/

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
