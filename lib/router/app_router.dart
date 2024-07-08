import 'package:akadomen/router/page_transition.dart';
import 'package:akadomen/views/screens/home.dart';
import 'package:akadomen/views/screens/register.dart';
import 'package:flutter/material.dart';

import '../utils/constants/routes.dart';
import '../views/screens/login.dart';
import '../views/screens/splash.dart';

abstract class AppRouter {
  const AppRouter._();
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteManager.initialRoute:
        return PageTransitionManager.fadeTransition(const SplashScreen());
      case RouteManager.login:
        return PageTransitionManager.fadeTransition(const LoginScreen());
      case RouteManager.register:
        return PageTransitionManager.materialSlideTransition(
            const RegisterScreen());
      case RouteManager.home:
        return PageTransitionManager.materialSlideTransition(
            const HomeScreen());
      default:
        return null;
    }
  }
}
