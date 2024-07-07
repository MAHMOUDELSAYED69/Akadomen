import 'package:flutter/material.dart';

import '../utils/constants/routes.dart';
import '../views/splash.dart';

abstract class AppRouter {
  const AppRouter._();
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteManager.initialRoute:
        return _materialPageRoute(const SplashScreen());
      default:
        return null;
    }
  }

  static _materialPageRoute(Widget screen) {
    return MaterialPageRoute(builder: (_) => screen);
  }
}
