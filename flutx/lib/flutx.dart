library flutx;

import 'package:flutx/core/logs/log.dart';
import 'package:flutx/themes/app_theme_notifier.dart';


export 'widgets/app_bar/app_bar.dart';

class FlutX {

  // entry point of the package
  init(){
    FxAppThemeNotifier().init();
  }

  static enableLog(){
    FxLog.enable();
  }

  static disableLog(){
    FxLog.disable();
  }


}
