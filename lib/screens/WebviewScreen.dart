

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutx/themes/app_theme.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile_ticketing/utils/SizeConfig.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../AppTheme.dart';
import '../AppThemeNotifier.dart';

class WebviewScreen extends StatefulWidget {
  @override
  _WebviewScreenState createState() =>
      _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  late ThemeData themeData;
  CustomAppTheme? customAppTheme;

  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();


  @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    customAppTheme  = AppTheme.getCustomAppTheme(1);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.getThemeFromThemeMode(1),
          home: Scaffold(
            appBar: AppBar(


              title: FxText.b1(
                "GRAFIK LAPORAN",
                fontWeight: 700,
                letterSpacing: 0.5,
              ),
              elevation: 0,
              centerTitle: true,
              backgroundColor: FxAppTheme.theme.scaffoldBackgroundColor,
              automaticallyImplyLeading: false,
            ),
              body:SafeArea(
                  child: Column(children: <Widget>[
                    /*TextField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search)
                      ),
                      controller: urlController,
                      keyboardType: TextInputType.url,
                      onSubmitted: (value) {
                        var url = Uri.parse(value);
                        if (url.scheme.isEmpty) {
                          url = Uri.parse("https://www.google.com/search?q=" + value);
                        }
                        webViewController?.loadUrl(
                            urlRequest: URLRequest(url: url));
                      },
                    ),*/
                    Expanded(
                      child: Stack(
                        children: [
                          InAppWebView(
                            key: webViewKey,
                            initialUrlRequest:
                            URLRequest(url: Uri.parse('https://manifest.ditfrek.postel.go.id/engine.php?class=TableauConnect&chart=StoryTicket')),
                            initialOptions: options,
                            pullToRefreshController: pullToRefreshController,
                            onWebViewCreated: (controller) {
                              webViewController = controller;
                            },
                            onLoadStart: (controller, url) {
                              setState(() {
                                this.url = url.toString();
                                urlController.text = this.url;
                              });
                            },
                            androidOnPermissionRequest: (controller, origin, resources) async {
                              return PermissionRequestResponse(
                                  resources: resources,
                                  action: PermissionRequestResponseAction.GRANT);
                            },
                            shouldOverrideUrlLoading: (controller, navigationAction) async {
                              var uri = navigationAction.request.url!;

                              if (![ "http", "https", "file", "chrome",
                                "data", "javascript", "about"].contains(uri.scheme)) {
                                if (await canLaunch(url)) {
                                  // Launch the App
                                  await launch(
                                    url,
                                  );
                                  // and cancel the request
                                  return NavigationActionPolicy.CANCEL;
                                }
                              }

                              return NavigationActionPolicy.ALLOW;
                            },
                            onLoadStop: (controller, url) async {
                              pullToRefreshController.endRefreshing();
                              setState(() {
                                this.url = url.toString();
                                urlController.text = this.url;
                              });
                            },
                            onLoadError: (controller, url, code, message) {
                              pullToRefreshController.endRefreshing();
                            },
                            onProgressChanged: (controller, progress) {
                              if (progress == 100) {
                                pullToRefreshController.endRefreshing();
                              }
                              setState(() {
                                this.progress = progress / 100;
                                urlController.text = this.url;
                              });
                            },
                            onUpdateVisitedHistory: (controller, url, androidIsReload) {
                              setState(() {
                                this.url = url.toString();
                                urlController.text = this.url;
                              });
                            },
                            onConsoleMessage: (controller, consoleMessage) {
                              print(consoleMessage);
                            },
                          ),
                          progress < 1.0
                              ? LinearProgressIndicator(value: progress)
                              : Container(),
                        ],
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // ElevatedButton(
                        //   child: Icon(Icons.arrow_back),
                        //   onPressed: () {
                        //     // webViewController?.goBack();
                        //   },
                        // ),
                        // ElevatedButton(
                        //   child: Icon(Icons.arrow_forward),
                        //   onPressed: () {
                        //     // webViewController?.goForward();
                        //   },
                        // ),
                        ElevatedButton(
                          child: Icon(Icons.refresh),
                          onPressed: () {
                            webViewController?.reload();
                          },
                        ),
                      ],
                    ),
                  ])),
          ),
        );

  }
//'https://manifest.ditfrek.postel.go.id/engine.php?class=TableauConnect&chart=StoryTicket'
  Widget singleChoice({required String title}) {
    return Container(
      padding: Spacing.fromLTRB(24, 16, 0, 16),
      decoration: BoxDecoration(
          color: customAppTheme?.bgLayer1 ?? Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(MySize.size8!))),
      child: Text(
        title,
        style: AppTheme.getTextStyle(themeData.textTheme.bodyText1,
            color: themeData.colorScheme.onBackground, fontWeight: 500),
      ),
    );
  }
}
