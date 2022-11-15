import 'package:flutter/cupertino.dart';
import 'package:photoshare/main.dart';

import '../photoshare.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list =
      <String, WidgetBuilder>{
    '\home': (_) => const PhotoShare(),
  };
  static String initial = '/home';

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}
