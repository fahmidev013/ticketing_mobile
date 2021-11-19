
import 'package:flutter/material.dart';
import 'package:flutx/themes/app_theme.dart';
import 'package:flutx/themes/text_style.dart';
import 'package:flutx/utils/spacing.dart';
import 'package:flutx/widgets/button/button.dart';
import 'package:flutx/widgets/card/card.dart';
import 'package:flutx/widgets/container/container.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile_ticketing/model/Issue.dart';
import 'package:mobile_ticketing/services/ApiServices.dart';
import 'package:mobile_ticketing/utils/SizeConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../AppTheme.dart';
import 'IssueDetailScreen.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key? key, required this.strList}) : super(key: key);

  final List<String>? strList;
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}



class _NotificationScreenState extends State<NotificationScreen> {

  late List<Issue> unreadIssue;
  final ApiService api = ApiService();


  @override
  void initState() {
    super.initState();

  /*  setState(() {
      unreadIssue = [];
    });*/
  }


  @override
  Widget build(BuildContext context) {
    return Theme(
      data: FxAppTheme.theme.copyWith(
          colorScheme: AppTheme.theme.colorScheme
              .copyWith(
              secondary: AppTheme.customTheme.groceryPrimary.withAlpha(80))),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: FxAppTheme.theme.scaffoldBackgroundColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: FxText.sh1("Notifikasi", fontWeight: 600),
          actions: <Widget>[
            Container(
              margin: Spacing.right(16),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  MdiIcons.notificationClearAll,
                  size: 24,
                  color: AppTheme.theme.colorScheme.onBackground,
                ),
              ),
            )
          ],
        ),
        body: FutureBuilder(
          future: _getUnreadIssue(widget.strList),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if( snapshot.connectionState == ConnectionState.waiting){
              return  Center(child: Text('Please wait its loading...'));
            }else{
              if (snapshot.hasError)
                return Center(child: Text('Error: ${snapshot.error}'));
              else
                return ListView(
                    padding: FxSpacing.horizontal(24,),
                    children: [
                      Column(
                        children: _buildChatList(),
                      ),
                    ]
                );
            }
          },
        )
      ),
    );
  }

  Widget singleNotification(
      {required String image, Widget? text, required String time}) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FxContainer.rounded(
            width: 52,
            height: 52,
            padding: Spacing.all(10),
            color: AppTheme.customTheme.groceryPrimary.withAlpha(40),
            child: Image.asset(image),
          ),
          Expanded(
            child: Container(margin: Spacing.horizontal(16), child: text),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              FxText.caption(time,
                  muted: true, fontWeight: 500, letterSpacing: -0.2),
            ],
          )
        ],
      ),
    );
  }

  List<Widget> _buildChatList() {
    List<Widget> list = [];

    list.add(FxSpacing.width(16));

    for (int i = 0; i < unreadIssue.length; i++) {
      list.add(_buildSingleChat(unreadIssue[i]));
    }
    return list;
  }


  Widget _buildSingleChat(Issue chat) {
    return FxCard(
      onTap: () {
        print('Ke detail page ${chat.issue_id}');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>
            IssueDetailScreen(issue: chat, title: chat.issue_id.toString())));
      },
      margin: FxSpacing.bottom(16),
      paddingAll: 16,
      borderRadiusAll: 16,
      child: Row(
        children: [
          Stack(
            children: [
              FxContainer.rounded(
                paddingAll: 0,
                child: Image(
                  height: 54,
                  width: 54,
                  image: AssetImage('assets/logo/logo.png'),
                ),
              ),
              /*Positioned(
              right: 4,
              bottom: 2,
              child: FxContainer.rounded(
                paddingAll: 5,
                child: Container(),
                color: AppTheme.customTheme.groceryPrimary,
              ),
            )*/
            ],
          ),
          FxSpacing.width(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FxText.b2(
                  'Ticket #${chat.issue_id}: ${chat.issue_labels}',
                  fontWeight: 600,
                  fontSize: 12,
                ),
                FxSpacing.height(4),
                FxText.caption(
                  chat.issue_title,
                  xMuted: false,
                  muted: !true,
                  fontWeight: true ? 400 : 600,
                  fontSize: 10,
                ),
              ],
            ),
          ),
          FxSpacing.width(8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FxText.overline(
                chat.issue_register_date,
                color: FxAppTheme.theme.colorScheme.onBackground,
                xMuted: true,
              ),

              false ? FxSpacing.height(16) : FxContainer.rounded(
                paddingAll: 6,
                color: chat.issue_priority == 'Major'
                    ? Color(0xffFF0000)
                    : const Color(0xffFFA500),
                child: FxText.overline(
                  '',
                  color: AppTheme.customTheme.medicareOnPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<List<Issue>> _getUnreadIssue(List<String>? strList) async {
    unreadIssue = await api.getNotifList(strList);
    return unreadIssue;
  }


}
/*class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: FxAppTheme.theme.copyWith(
          colorScheme: AppTheme.theme.colorScheme
              .copyWith(secondary: AppTheme.customTheme.groceryPrimary.withAlpha(80))),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: FxAppTheme.theme.scaffoldBackgroundColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: FxText.sh1("Notifikasi", fontWeight: 600),
          actions: <Widget>[
            Container(
              margin: Spacing.right(16),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  MdiIcons.notificationClearAll,
                  size: 24,
                  color: AppTheme.theme.colorScheme.onBackground,
                ),
              ),
            )
          ],
        ),
        body: ListView(
          padding: Spacing.all(16),
          children: <Widget>[
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  FxText.b1(
                    "Open",
                    fontWeight: 600,
                  ),
                  FxContainer.rounded(
                    margin: Spacing.left(8),
                    width: 18,
                    paddingAll: 0,
                    height: 18,
                    color: AppTheme.customTheme.groceryPrimary.withAlpha(40),
                    child: Center(
                        child: FxText.overline(
                      "2",
                      fontWeight: 600,
                      color: AppTheme.customTheme.groceryPrimary,
                    )),
                  )
                ],
              ),
            ),
            Spacing.height(24),
            singleNotification(
                image: './assets/grocery/product-5.png',
                text: RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "50% OFF ",
                        style: FxTextStyle.button(
                            color: AppTheme.customTheme.groceryPrimary,
                            fontWeight: 600,
                            letterSpacing: 0.2)),
                    TextSpan(
                      text: "in ultraboost all puma ltd shoes",
                      style: FxTextStyle.button(
                          color: AppTheme.theme.colorScheme.onBackground,
                          fontWeight: 500,
                          letterSpacing: 0.2),
                    )
                  ]),
                ),
                time: "9:35 AM"),
            FxSpacing.height(24),
            singleNotification(
                image: './assets/grocery/product-2.png',
                text: RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "30% OFF ",
                        style: FxTextStyle.button(
                            color: AppTheme.customTheme.groceryPrimary,
                            fontWeight: 600,
                            letterSpacing: 0.2)),
                    TextSpan(
                        text: "in all cake till 31 july",
                        style: FxTextStyle.button(
                            color: AppTheme.theme.colorScheme.onBackground,
                            fontWeight: 500,
                            letterSpacing: 0.2))
                  ]),
                ),
                time: "9:35 AM"),
            FxSpacing.height(24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                FxText.b1(
                  "Closed",
                  fontWeight: 600,
                ),
                FxContainer.rounded(
                  margin: Spacing.left(8),
                  width: 18,
                  paddingAll: 0,
                  height: 18,
                  color: AppTheme.customTheme.groceryPrimary.withAlpha(40),
                  child: Center(
                      child: FxText.overline(
                    "8",
                    fontWeight: 600,
                    color: AppTheme.customTheme.groceryPrimary,
                  )),
                )
              ],
            ),
            FxSpacing.height(24),
            singleNotification(
                image: './assets/grocery/product-3.png',
                text: FxText.button(
                    "Your cake order has been delivered at Himalaya",
                    color: AppTheme.theme.colorScheme.onBackground,
                    fontWeight: 500,
                    letterSpacing: 0),
                time: "Just Now"),
            FxSpacing.height(24),
            singleNotification(
                image: './assets/grocery/product-2.png',
                text: FxText.button("last order has been cancelled by seller",
                    color: AppTheme.theme.colorScheme.onBackground,
                    fontWeight: 500,
                    letterSpacing: 0),
                time: "14 July"),
            FxSpacing.height(24),
            Center(
              child: FxButton.text(
                splashColor: AppTheme.customTheme.groceryPrimary.withAlpha(40),
                child: FxText.button("View all",
                    color: AppTheme.customTheme.groceryPrimary,
                    fontWeight: 600,
                    letterSpacing: 0.2),
                onPressed: () {
                  Navigator.of(context).push(new MaterialPageRoute<Null>(
                      builder: (BuildContext context) {
                        return NotificationScreen();
                      },
                      fullscreenDialog: true));
                },
              ),
            ),
            FxSpacing.height(24),

          ],
        ),
      ),
    );
  }

  Widget singleNotification(
      {required String image, Widget? text, required String time}) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FxContainer.rounded(
            width: 52,
            height: 52,
            padding: Spacing.all(10),
            color: AppTheme.customTheme.groceryPrimary.withAlpha(40),
            child: Image.asset(image),
          ),
          Expanded(
            child: Container(margin: Spacing.horizontal(16), child: text),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              FxText.caption(time,
                  muted: true, fontWeight: 500, letterSpacing: -0.2),
            ],
          )
        ],
      ),
    );
  }
}*/
