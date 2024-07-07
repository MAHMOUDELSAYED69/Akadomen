import 'package:flutter/material.dart';

import '../utils/constants/routes.dart';
import '../views/screens/login.dart';
import '../views/screens/splash.dart';

abstract class AppRouter {
  const AppRouter._();
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteManager.initialRoute:
        return _materialPageRoute(const SplashScreen());
      case RouteManager.login:
        return _materialPageRoute(const LoginScreen());
      default:
        return null;
    }
  }

  static _materialPageRoute(Widget screen) {
    return MaterialPageRoute(builder: (_) => screen);
  }
}
