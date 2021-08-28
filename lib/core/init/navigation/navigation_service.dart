import 'package:flutter/cupertino.dart';

import 'l_navigation_service.dart';

/// Navigation service that takes some arguments and navigates with the help of navigatorKey.
class NavigationService implements INavigationService {
  static final NavigationService _instance = NavigationService._init();
  static NavigationService get instance => _instance;

  NavigationService._init();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  // ignore: prefer_function_declarations_over_variables
  final removeAllOldRoutes = (route) => false;

  @override
  Future<void> navigateToPage(
      {String path = '/', Object data = const {}}) async {
    await navigatorKey.currentState?.pushNamed(path, arguments: data);
  }

  @override
  Future<void> navigateToPageClear(
      {String path = '/', Object data = const {}}) async {
    await navigatorKey.currentState
        ?.pushNamedAndRemoveUntil(path, removeAllOldRoutes, arguments: data);
  }
}
