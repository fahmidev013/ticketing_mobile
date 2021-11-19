
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile_ticketing/model/Issue.dart';
import 'package:mobile_ticketing/utils/SizeConfig.dart';
import 'package:provider/provider.dart';
import '../../AppTheme.dart';
import '../AppThemeNotifier.dart';

class IssueDetailScreen extends StatefulWidget {
  const IssueDetailScreen({Key? key, required this.issue, required this.title}) : super(key: key);
  final String title;
  final Issue issue;

  @override
  _IssueDetailScreenState createState() => _IssueDetailScreenState();
}

class _IssueDetailScreenState extends State<IssueDetailScreen> {
  late ThemeData themeData;
  late CustomAppTheme customAppTheme;


  Widget build(BuildContext context) {
    themeData = Theme.of(context);

        customAppTheme = AppTheme.getCustomAppTheme(1);
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.getThemeFromThemeMode(1),
            home: Scaffold(
                body: Container(
              color: customAppTheme.bgLayer1,
              child: Column(
                children: [
                  Container(
                    child: Stack(
                      children: [
                        Image(
                          image: AssetImage(
                              './assets/logo/app_logo.jpeg'),
                          fit: BoxFit.contain,
                          width: MySize.safeWidth,
                          height: MySize.getScaledSizeHeight(240),
                        ),
                        Positioned(
                          child: Container(
                            margin: Spacing.fromLTRB(24, 48, 24, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: Spacing.all(8),
                                    decoration: BoxDecoration(
                                      color: customAppTheme.bgLayer1,
                                      border: Border.all(
                                          color: customAppTheme.bgLayer4,
                                          width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(MySize.size8!)),
                                    ),
                                    child: Icon(MdiIcons.chevronLeft,
                                        color: themeData
                                            .colorScheme.onBackground
                                            .withAlpha(220),
                                        size: MySize.size20),
                                  ),
                                ),
                                /*Container(
                                  padding: Spacing.all(8),
                                  decoration: BoxDecoration(
                                    color: customAppTheme.bgLayer1,
                                    border: Border.all(
                                        color: customAppTheme.bgLayer4,
                                        width: 1),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(MySize.size8!)),
                                  ),
                                  child: Icon(MdiIcons.shareOutline,
                                      color: themeData.colorScheme.onBackground
                                          .withAlpha(220),
                                      size: MySize.size20),
                                ),*/
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: Spacing.vertical(16),
                      children: [
                        Container(
                          margin: Spacing.fromLTRB(24, 0, 24, 0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.issue.issue_title,
                                  style: AppTheme.getTextStyle(
                                      themeData.textTheme.headline5,
                                      fontSize: 22,
                                      color: themeData.colorScheme.onBackground,
                                      fontWeight: 600),
                                ),
                              ),
                              Container(
                                margin: Spacing.left(16),
                                padding: Spacing.all(8),
                                decoration: BoxDecoration(
                                    color: themeData.colorScheme.primary.withAlpha(24)
                                        .withAlpha(20),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(MySize.size8!))),
                                child: Icon(
                                  MdiIcons.heartOutline,
                                  size: MySize.size18,
                                  color: themeData.colorScheme.primary
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: Spacing.fromLTRB(24,16,24,0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: Spacing.all(8),
                                    decoration: BoxDecoration(
                                        color: themeData.colorScheme.primary
                                            .withAlpha(24),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(MySize.size8!))),
                                    child: Icon(
                                      MdiIcons.ticket,
                                      size: MySize.size18,
                                      color: themeData.colorScheme.primary,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: Spacing.left(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Nomor Tiket",
                                            style: AppTheme.getTextStyle(
                                                themeData.textTheme.caption,
                                                fontWeight: 600,
                                                color: themeData
                                                    .colorScheme.onBackground),
                                          ),
                                          Container(
                                            margin: Spacing.top(2),
                                            child: Text(
                                              widget.issue.issue_id.toString(),
                                              style: AppTheme.getTextStyle(
                                                  themeData.textTheme.caption,fontSize: 12,
                                                  fontWeight: 500,
                                                  color: themeData
                                                      .colorScheme.onBackground,
                                                  xMuted: true),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                margin: Spacing.top(16),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: Spacing.all(8),
                                      decoration: BoxDecoration(
                                          color: themeData.colorScheme.primary
                                              .withAlpha(24),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(MySize.size8!))),
                                      child: Icon(
                                        MdiIcons.calendar,
                                        size: MySize.size18,
                                        color: themeData.colorScheme.primary,
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: Spacing.left(16),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Tanggal Lapor",
                                              style: AppTheme.getTextStyle(
                                                  themeData.textTheme.caption,
                                                  fontWeight: 600,
                                                  color: themeData
                                                      .colorScheme.onBackground),
                                            ),
                                            Container(
                                              margin: Spacing.top(2),
                                              child: Text(
                                                widget.issue.issue_register_date,
                                                style: AppTheme.getTextStyle(
                                                    themeData.textTheme.caption,fontSize: 12,
                                                    fontWeight: 500,
                                                    color: themeData
                                                        .colorScheme.onBackground,
                                                    xMuted: true),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: Spacing.top(16),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: Spacing.all(8),
                                      decoration: BoxDecoration(
                                          color: themeData.colorScheme.primary
                                              .withAlpha(24),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(MySize.size8!))),
                                      child: Icon(
                                        MdiIcons.account,
                                        size: MySize.size18,
                                        color: themeData.colorScheme.primary,
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: Spacing.left(16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Ditangani Oleh",
                                              style: AppTheme.getTextStyle(
                                                  themeData.textTheme.caption,
                                                  fontWeight: 600,
                                                  color: themeData
                                                      .colorScheme.onBackground),
                                            ),
                                            Container(
                                              margin: Spacing.top(2),
                                              child: Text(
                                                widget.issue.issue_user_name,
                                                style: AppTheme.getTextStyle(
                                                    themeData.textTheme.caption,fontSize: 12,
                                                    fontWeight: 500,
                                                    color: themeData
                                                        .colorScheme.onBackground,
                                                    xMuted: true),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: Spacing.top(16),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: Spacing.all(8),
                                      decoration: BoxDecoration(
                                          color: themeData.colorScheme.primary
                                              .withAlpha(24),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(MySize.size8!))),
                                      child: Icon(
                                        MdiIcons.listStatus,
                                        size: MySize.size18,
                                        color: themeData.colorScheme.primary,
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: Spacing.left(16),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Status",
                                              style: AppTheme.getTextStyle(
                                                  themeData.textTheme.caption,
                                                  fontWeight: 600,
                                                  color: themeData
                                                      .colorScheme.onBackground),
                                            ),
                                            Container(
                                              margin: Spacing.top(2),
                                              child: Text(
                                                widget.issue.issue_status,
                                                style: AppTheme.getTextStyle(
                                                    themeData.textTheme.caption,fontSize: 12,
                                                    fontWeight: 500,
                                                    color: themeData
                                                        .colorScheme.onBackground,
                                                    xMuted: true),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              Container(
                                margin: Spacing.top(16),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: Spacing.all(8),
                                      decoration: BoxDecoration(
                                          color: themeData.colorScheme.primary
                                              .withAlpha(24),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(MySize.size8!))),
                                      child: Icon(
                                        MdiIcons.listStatus,
                                        size: MySize.size18,
                                        color: themeData.colorScheme.primary,
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: Spacing.left(16),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Status Perbaikan",
                                              style: AppTheme.getTextStyle(
                                                  themeData.textTheme.caption,
                                                  fontWeight: 600,
                                                  color: themeData
                                                      .colorScheme.onBackground),
                                            ),
                                            Container(
                                              margin: Spacing.top(2),
                                              child: Text(
                                                widget.issue.issue_resolution,
                                                style: AppTheme.getTextStyle(
                                                    themeData.textTheme.caption,fontSize: 12,
                                                    fontWeight: 500,
                                                    color: themeData
                                                        .colorScheme.onBackground,
                                                    xMuted: true),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: Spacing.top(16),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: Spacing.all(8),
                                      decoration: BoxDecoration(
                                          color: themeData.colorScheme.primary
                                              .withAlpha(24),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(MySize.size8!))),
                                      child: Icon(
                                        MdiIcons.calendar,
                                        size: MySize.size18,
                                        color: themeData.colorScheme.primary,
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: Spacing.left(16),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Tanggal Perbaikan",
                                              style: AppTheme.getTextStyle(
                                                  themeData.textTheme.caption,
                                                  fontWeight: 600,
                                                  color: themeData
                                                      .colorScheme.onBackground),
                                            ),
                                            Container(
                                              margin: Spacing.top(2),
                                              child: Text(
                                                widget.issue.issue_close_date,
                                                style: AppTheme.getTextStyle(
                                                    themeData.textTheme.caption,fontSize: 12,
                                                    fontWeight: 500,
                                                    color: themeData
                                                        .colorScheme.onBackground,
                                                    xMuted: true),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              Container(
                                margin: Spacing.top(16),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: Spacing.all(8),
                                      decoration: BoxDecoration(
                                          color: themeData.colorScheme.primary
                                              .withAlpha(24),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(MySize.size8!))),
                                      child: Icon(
                                        MdiIcons.timeline,
                                        size: MySize.size18,
                                        color: themeData.colorScheme.primary,
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: Spacing.left(16),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Proyek",
                                              style: AppTheme.getTextStyle(
                                                  themeData.textTheme.caption,
                                                  fontWeight: 600,
                                                  color: themeData
                                                      .colorScheme.onBackground),
                                            ),
                                            Container(
                                              margin: Spacing.top(2),
                                              child: Text(
                                                widget.issue.issue_project,
                                                style: AppTheme.getTextStyle(
                                                    themeData.textTheme.caption,fontSize: 12,
                                                    fontWeight: 500,
                                                    color: themeData
                                                        .colorScheme.onBackground,
                                                    xMuted: true),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              Container(
                                margin: Spacing.top(16),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: Spacing.all(8),
                                      decoration: BoxDecoration(
                                          color: themeData.colorScheme.primary
                                              .withAlpha(24),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(MySize.size8!))),
                                      child: Icon(
                                        MdiIcons.application,
                                        size: MySize.size18,
                                        color: themeData.colorScheme.primary,
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: Spacing.left(16),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Aplikasi Terdampak",
                                              style: AppTheme.getTextStyle(
                                                  themeData.textTheme.caption,
                                                  fontWeight: 600,
                                                  color: themeData
                                                      .colorScheme.onBackground),
                                            ),
                                            Container(
                                              margin: Spacing.top(2),
                                              child: Text(
                                                widget.issue.issue_labels,
                                                style: AppTheme.getTextStyle(
                                                    themeData.textTheme.caption,fontSize: 12,
                                                    fontWeight: 500,
                                                    color: themeData
                                                        .colorScheme.onBackground,
                                                    xMuted: true),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),


                        Container(
                          margin: Spacing.fromLTRB(24, 24, 24, 0),
                          child: Text(
                            "Keterangan",
                            style: AppTheme.getTextStyle(
                                themeData.textTheme.subtitle1,
                                fontWeight: 700,
                                color: themeData.colorScheme.onBackground),
                          ),
                        ),
                        Container(
                          margin: Spacing.fromLTRB(24, 12, 24, 0),
                          child: RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: widget.issue.issue_desc,
                                  style: AppTheme.getTextStyle(
                                      themeData.textTheme.subtitle2,
                                      color: themeData.colorScheme.onBackground,
                                      muted: true,
                                      fontWeight: 500)),
                             /* TextSpan(
                                  text: " Read More",
                                  style: AppTheme.getTextStyle(
                                      themeData.textTheme.caption,
                                      color: themeData.colorScheme.primary,
                                      fontWeight: 600))*/
                            ]),
                          ),
                        ),
                        /*Container(
                          margin: Spacing.fromLTRB(24, 24, 24, 0),
                          child: Text(
                            "Location",
                            style: AppTheme.getTextStyle(
                                themeData.textTheme.subtitle1,
                                fontWeight: 700,
                                color: themeData.colorScheme.onBackground),
                          ),
                        ),
                        Container(
                          margin: Spacing.fromLTRB(24, 16, 24, 0),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(MySize.size8!)),
                            child: Image(
                              image:
                                  AssetImage('./assets/other/map-md-snap.png'),
                              height: MySize.getScaledSizeHeight(200),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),*/
                        Container(
                          margin: Spacing.fromLTRB(24, 16, 24,0),
                          child: ElevatedButton(

                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Kembali",
                              style: AppTheme.getTextStyle(
                                  themeData.textTheme.bodyText2,
                                  fontWeight: 600,
                                  color: themeData.colorScheme.onPrimary),
                            ),
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(Spacing.xy(16, 0))
                            ),                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}
