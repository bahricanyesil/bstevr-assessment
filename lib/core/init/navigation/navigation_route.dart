import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../view/view_shelf.dart';
import '../../core_shelf.dart';

/// Main place that navigation is performed acc. to the argument name.
class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.coinDetector:
        return normalNavigate(const CoinDetectorScreen());
      case NavigationConstants.speedPrototyping:
        return normalNavigate(const SpeedPrototypingScreen());
      default:
        return normalNavigate(const SpeedPrototypingScreen());
    }
  }

  MaterialPageRoute normalNavigate(Widget widget) {
    return MaterialPageRoute(
      builder: (context) => widget,
    );
  }
}
