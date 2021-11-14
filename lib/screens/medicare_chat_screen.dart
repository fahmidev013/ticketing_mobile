
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/themes/app_theme.dart';
import 'package:flutx/themes/text_style.dart';
import 'package:flutx/utils/spacing.dart';
import 'package:flutx/widgets/card/card.dart';
import 'package:flutx/widgets/container/container.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:flutx/widgets/text_field/text_field.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile_ticketing/model/Issue.dart';
import 'package:mobile_ticketing/screens/EventSingleEventScreen.dart';
import 'package:mobile_ticketing/utils/SizeConfig.dart';

import '../../AppTheme.dart';
import 'grocery_notification_dialog.dart';

class MediCareChatScreen extends StatefulWidget {
  const MediCareChatScreen({Key? key, required this.issue, required this.title}) : super(key: key);
  final String title;
  final List<Issue>? issue;
  @override
  _MediCareChatScreenState createState() => _MediCareChatScreenState();
}

class _MediCareChatScreenState extends State<MediCareChatScreen> {
  // List<Issue> chatList=[];

  List<Widget> _buildChatList() {
    List<Widget> list = [];

    list.add(FxSpacing.width(16));

    for (int i = 0; i < widget.issue!.length; i++) {
      list.add(_buildSingleChat(widget.issue![i]));
    }
    return list;
  }


  Widget _buildSingleChat(Issue chat){
  return FxCard(
    onTap: (){

      print('Ke detail page ${chat.issue_id}' );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => EventSingleEventScreen(issue: chat,title: chat.issue_id.toString())));
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
                image: AssetImage('assets/images/avatar-2.jpg'),
              ),
            ),
            Positioned(
              right: 4,
              bottom: 2,
              child: FxContainer.rounded(
                paddingAll: 5,
                child: Container(),
                color: AppTheme.customTheme.groceryPrimary,
              ),
            )
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

            false?FxSpacing.height(16):FxContainer.rounded(
              paddingAll: 6,
              color: chat.issue_priority == 'Major' ? Color(0xffFF0000) : const Color(0xffFFA500),
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

@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(
            MdiIcons.chevronLeft,
            color: Colors.black,
          ),
        ),
        title: FxText.b1(
          widget.title,
          fontWeight: 700,
          letterSpacing: 0.5,
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: FxAppTheme.theme.scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: FxSpacing.horizontal(24,),
        children: [
          FxTextField(
            textFieldStyle: FxTextFieldStyle.outlined,
            labelText: 'Cari..',
            focusedBorderColor: AppTheme.customTheme.medicarePrimary,
            cursorColor: AppTheme.customTheme.medicarePrimary,
            labelStyle: FxTextStyle.caption(
                color: FxAppTheme.theme.colorScheme.onBackground, xMuted: true),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            filled: true,
            fillColor: AppTheme.customTheme.medicarePrimary.withAlpha(40),
            suffixIcon: Icon(
              FeatherIcons.search,
              color: AppTheme.customTheme.medicarePrimary,
              size: 20,
            ),
          ),
          FxSpacing.height(20),
          Column(
            children: _buildChatList(),
          ),
        ],
      ),
    );
  }
}
