
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/utils/spacing.dart';
import 'package:flutx/utils/text_utils.dart';
import 'package:flutx/widgets/container/container.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:flutx/widgets/text_field/text_field.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile_ticketing/model/User.dart';
import 'package:mobile_ticketing/model/category.dart';
import 'package:mobile_ticketing/model/product.dart';
import 'package:mobile_ticketing/screens/HealthActivityScreen.dart';
import 'package:mobile_ticketing/utils/Generator.dart';
import 'package:mobile_ticketing/utils/SizeConfig.dart';
import 'package:provider/provider.dart';
import '../../AppTheme.dart';
import '../AppThemeNotifier.dart';
import 'HealthNewActivityScreen.dart';
import 'grocery_notification_dialog.dart';

class HealthHomeScreen extends StatefulWidget {
  HealthHomeScreen({Key? key, required this.rootContext, required this.user}) : super(key: key);

  final User? user;
  final BuildContext rootContext;

  @override
  _HealthHomeScreenState createState() => _HealthHomeScreenState();
}

class _HealthHomeScreenState extends State<HealthHomeScreen> {
  late ThemeData themeData;
  late CustomAppTheme customAppTheme;
  late List<Product> products;
  late List<Category> categories;



  @override
  void initState() {
    super.initState();
    products = Product.getList();
    categories = Category.getList();
  }

  Widget build(BuildContext context) {
    MySize().init(context);
    themeData = Theme.of(context);
    customAppTheme  = AppTheme.getCustomAppTheme(1);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.getThemeFromThemeMode(1),
          home: Scaffold(
              floatingActionButton: FloatingActionButton.extended(
                  backgroundColor: themeData.colorScheme.primary,
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => HealthNewActivityScreen()));
                  },
                  label: Row(
                    children: [
                      Icon(
                        MdiIcons.plus,
                        color: themeData.colorScheme.onPrimary,size: MySize.size18,
                      ),
                      Container(
                        margin: Spacing.left(4),
                        child: Text(
                          "Activity",
                          style: AppTheme.getTextStyle(
                              themeData.textTheme.bodyText2,
                              color: themeData.colorScheme.onPrimary,
                              fontWeight: 500),
                        ),
                      ),
                    ],
                  )),
              body: Container(

                color: customAppTheme.bgLayer1,
                child: ListView(
                  padding: Spacing.top(48),
                  children: [
                    Padding(
                      padding: FxSpacing.horizontal(24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FxText.sh1('Halo \n' + 'sss',
                              color: AppTheme.theme.colorScheme.onBackground,
                              fontWeight: 600),
                          InkWell(
                            onTap: () {
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
                                  size: 22,
                                  color: AppTheme.theme.colorScheme.onBackground
                                      .withAlpha(200),
                                ),
                                Positioned(
                                  right: -2,
                                  top: -2,
                                  child: Container(
                                    padding: Spacing.zero,
                                    height: 14,
                                    width: 14,
                                    decoration: BoxDecoration(
                                        color: AppTheme.customTheme.groceryPrimary,
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(40))),
                                    child: Center(
                                      child: FxText.overline(
                                        "2",
                                        color: AppTheme.customTheme.groceryOnPrimary,
                                        fontSize: 9,
                                        fontWeight: 500,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    FxSpacing.height(8),
                    Padding(
                      padding: FxSpacing.horizontal(24),
                      child: FxText.b2("What would you buy today?",
                          color: AppTheme.theme.colorScheme.onBackground,
                          fontWeight: 500,
                          xMuted: true),
                    ),
                    FxSpacing.height(24),
                    getBannerWidget(),
                    FxSpacing.height(24),
                    Padding(
                      padding: FxSpacing.horizontal(24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FxText.sh1("Categories",
                              letterSpacing: 0,
                              color: AppTheme.theme.colorScheme.onBackground,
                              fontWeight: 600),
                          FxText.caption("See All",
                              color: AppTheme.theme.colorScheme.onBackground,
                              fontWeight: 600,
                              xMuted: true,
                              letterSpacing: 0),
                        ],
                      ),
                    ),
                    FxSpacing.height(16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: buildCategories(),
                      ),
                    ),
                    FxSpacing.height(24),
                    Padding(
                      padding: FxSpacing.horizontal(24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FxText.sh1("Best Selling",
                              color: AppTheme.theme.colorScheme.onBackground,
                              fontWeight: 600),
                          FxText.caption("See All",
                              color: AppTheme.theme.colorScheme.onBackground,
                              fontWeight: 600,
                              xMuted: true,
                              letterSpacing: 0),
                        ],
                      ),
                    ),
                    FxSpacing.height(16),
                    Padding(
                      padding: FxSpacing.horizontal(24),
                      child: Column(
                        children: [
                          Text('hello')
                        ],
                      ),
                    ),

                    Container(
                      margin: Spacing.fromLTRB(24, 24, 24, 0),
                      padding: Spacing.horizontal(12),
                      decoration: BoxDecoration(
                          color: customAppTheme.bgLayer1,
                          borderRadius:
                          BorderRadius.all(Radius.circular(MySize.size8!)),
                          boxShadow: [
                            BoxShadow(
                              color: customAppTheme.shadowColor,
                              spreadRadius: 2,
                              blurRadius: MySize.size10!,
                              offset: Offset(0, MySize.size8!),
                            ),
                          ]),
                      child: Row(
                        children: [
                          Icon(
                            MdiIcons.magnify,
                            color:
                            themeData.colorScheme.primary.withAlpha(200),
                            size: MySize.size16,
                          ),
                          Expanded(
                            child: Container(
                              margin: Spacing.left(12),
                              child: TextFormField(
                                style: AppTheme.getTextStyle(
                                    themeData.textTheme.caption,
                                    color: themeData.colorScheme.onBackground,
                                    fontWeight: 500),
                                decoration: InputDecoration(
                                  fillColor: customAppTheme.bgLayer1,
                                  hintStyle: AppTheme.getTextStyle(
                                      themeData.textTheme.bodyText2,
                                      color:
                                      themeData.colorScheme.onBackground,
                                      muted: true,
                                      fontWeight: 500),
                                  hintText: "Cari Issue...",
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                textCapitalization:
                                TextCapitalization.sentences,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: Spacing.fromLTRB(24, 36, 24, 0),
                      padding: Spacing.all(24),
                      decoration: BoxDecoration(
                        color: themeData.colorScheme.primary,
                        borderRadius:
                        BorderRadius.all(Radius.circular(MySize.size12!)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Perhatian!",
                                style: AppTheme.getTextStyle(
                                    themeData.textTheme.bodyText1,
                                    color: themeData.colorScheme.onPrimary,
                                    fontWeight: 600),
                              ),
                              Icon(
                                MdiIcons.close,
                                color: themeData.colorScheme.onPrimary
                                    .withAlpha(200),
                                size: MySize.size16,
                              )
                            ],
                          ),
                          Container(
                            margin: Spacing.top(8),
                            width: MySize.safeWidth! * 0.6,
                            child: Text(
                              'Waktu SLA Issue maksimal adalah 3x24 jam, apabila belum ada response, mohon hubungi Subdit SIMS di LT.7',
                              style: AppTheme.getTextStyle(
                                  themeData.textTheme.bodyText2,
                                  color: themeData.colorScheme.onPrimary,
                                  fontWeight: 400,
                                  muted: true),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: Spacing.fromLTRB(24, 24, 24, 0),
                      child: Text(
                        "Menu Shortcut Aplikasi",
                        style: AppTheme.getTextStyle(
                            themeData.textTheme.subtitle1,
                            letterSpacing: -0.15,
                            color: themeData.colorScheme.onBackground,
                            fontWeight: 600,
                            muted: true),
                      ),
                    ),
                    Container(
                      margin: Spacing.top(24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          singleHelpWidget(
                              iconData: MdiIcons.book, title: "Status Issue"),
                          singleHelpWidget(
                              iconData: MdiIcons.pencil,
                              title: "Buat Issue"),
                          singleHelpWidget(
                              iconData: MdiIcons.downloadBox, title: "Unduh Laporan")
                        ],
                      ),
                    ),
                    Container(
                      margin: Spacing.top(24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          singleHelpWidget(
                              iconData: MdiIcons.chat,
                              title: "Call Center"),
                          singleHelpWidget(
                              iconData: MdiIcons.cellphoneSettings,
                              title: "Setting"),
                          singleHelpWidget(
                              iconData: MdiIcons.account, title: "Profil")
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        );

  }

  Widget singleHelpWidget({IconData? iconData, required String title, Color? color}) {
    return Container(
      width: (MySize.safeWidth! - MySize.getScaledSizeWidth(96)) / 3,
      padding: Spacing.fromLTRB(0, 20, 0, 20),
      decoration: BoxDecoration(
          color: customAppTheme.bgLayer1,
          borderRadius: BorderRadius.all(Radius.circular(MySize.size8!)),
          boxShadow: [
            BoxShadow(
                color: customAppTheme.shadowColor,
                blurRadius: MySize.size6!,
                offset: Offset(0, MySize.size4!))
          ]),
      child: Column(
        children: [
          Icon(
            iconData,
            color: color == null ? themeData.colorScheme.primary : color,
            size: MySize.size30,
          ),
          Container(
            margin: Spacing.top(8),
            child: Text(
              title,
              style: AppTheme.getTextStyle(themeData.textTheme.caption,
                  letterSpacing: 0,
                  color: themeData.colorScheme.onBackground,
                  fontWeight: 600),
            ),
          )
        ],
      ),
    );
  }

  Widget getBannerWidget() {
    return FxContainer(
      color: AppTheme.customTheme.groceryPrimary.withAlpha(28),
      padding: Spacing.all(24),
      margin: FxSpacing.horizontal(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FxText.b1("Enjoy the special offer\nup to 60%",
              color: AppTheme.customTheme.groceryPrimary,
              fontWeight: 600,
              letterSpacing: 0),
          FxSpacing.height(8),
          FxText.caption("at 15 - 25 March 2021",
              color: AppTheme.theme.colorScheme.onBackground.withAlpha(100),
              fontWeight: 500,
              letterSpacing: -0.2),
        ],
      ),
    );
  }

  List<Widget> buildCategories() {
    List<Widget> list = [];
    list.add(FxSpacing.width(24));
    for (int i = 0; i < categories.length; i++) {
      list.add(getSingleCategory(categories[i]));
      list.add(FxSpacing.width(16));
    }
    return list;
  }

  Widget getSingleCategory(Category category) {
    String heroTag = Generator.getRandomString(10);

    return Hero(
      tag: heroTag,
      child: FxContainer(
        width: 80,
        onTap: () {
          Navigator.push(
              widget.rootContext,
              PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (_, __, ___) =>
                      HealthActivityScreen()));
        },
        padding: Spacing.all(16),
        color: category.color,
        child: Column(
          children: [
            Image.asset(
              category.image,
              width: 28,
              height: 28,
            ),
            FxSpacing.height(4),
            FxText.overline(
              category.title,
              color: AppTheme.theme.colorScheme.onBackground,
            )
          ],
        ),
      ),
    );
  }

  List<Widget> buildProducts() {
    List<Widget> list = [];
    for (Product product in products) {
      list.add(getSingleProduct(product));
    }
    return list;
  }

  Widget getSingleProduct(Product product) {
    String heroKey = Generator.getRandomString(10);

    return InkWell(
      onTap: () {
        Navigator.push(
            widget.rootContext,
            PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                pageBuilder: (_, __, ___) =>
                    HealthActivityScreen()));
      },
      child: FxContainer(
        margin: Spacing.bottom(16),
        color: AppTheme.customTheme.groceryBg2,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FxContainer(
              color: AppTheme.customTheme.groceryPrimary.withAlpha(32),
              padding: Spacing.all(8),
              child: Hero(
                tag: heroKey,
                child: ClipRRect(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Image.asset(
                    product.image,
                    width: 72,
                    height: 72,
                  ),
                ),
              ),
            ),
            FxSpacing.width(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FxText.b2(product.name,
                      color: AppTheme.theme.colorScheme.onBackground,
                      fontWeight: 600),
                  FxSpacing.height(8),
                  FxText.overline(product.description,
                      color: AppTheme.theme.colorScheme.onBackground,
                      muted: true),
                  FxSpacing.height(8),
                  product.discountedPrice != product.price
                      ? Row(
                    children: [
                      FxText.caption(
                          "\$" +
                              FxTextUtils.doubleToString(product.price),
                          decoration: TextDecoration.lineThrough,
                          fontWeight: 500),
                      // Space.width(8),
                      FxSpacing.width(8),
                      FxText.b2(
                          "\$" +
                              FxTextUtils.doubleToString(
                                  product.discountedPrice),
                          color: AppTheme.theme.colorScheme.onBackground,
                          fontWeight: 700),
                    ],
                  )
                      : FxText.b2(
                      "\$" + FxTextUtils.doubleToString(product.price),
                      color: AppTheme.theme.colorScheme.onBackground,
                      fontWeight: 700),
                ],
              ),
            ),
            // Space.width(8),
            Icon(
              MdiIcons.heartOutline,
              color: AppTheme.customTheme.groceryPrimary,
              size: 18,
            )
          ],
        ),
      ),
    );
  }
}
