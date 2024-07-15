import 'package:akadomen/controllers/login/login_cubit.dart';
import 'package:akadomen/router/page_transition.dart';
import 'package:akadomen/views/screens/archive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/archive/archive_cubit.dart';
import '../controllers/calc/calccubit_cubit.dart';
import '../controllers/image/image_cubit.dart';
import '../controllers/invoice/invoice_cubit.dart';
import '../controllers/logout/logout_cubit.dart';
import '../controllers/register/register_cubit.dart';
import '../controllers/repository/fruits_repository.dart';
import '../utils/constants/routes.dart';
import '../views/screens/home.dart';
import '../views/screens/login.dart';
import '../views/screens/register.dart';
import '../views/screens/splash.dart';
import '../views/screens/settings.dart';

abstract class AppRouter {
  const AppRouter._();

  static final fruitsRepositoryCubit = FruitsRepositoryCubit();

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteManager.initialRoute:
        return PageTransitionManager.fadeTransition(BlocProvider(
          create: (context) => AuthStatus(),
          child: const SplashScreen(),
        ));
      case RouteManager.login:
        return PageTransitionManager.fadeTransition(BlocProvider(
          create: (context) => LoginCubit(),
          child: const LoginScreen(),
        ));
      case RouteManager.register:
        return PageTransitionManager.materialSlideTransition(BlocProvider(
          create: (context) => RegisterCubit(),
          child: const RegisterScreen(),
        ));
      case RouteManager.home:
        return PageTransitionManager.materialSlideTransition(MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => InvoiceCubit(),
            ),
            BlocProvider.value(value: fruitsRepositoryCubit..loadUserJuices()),
            BlocProvider(
              create: (context) => CalculatorCubit(),
            ),
          ],
          child: const HomeScreen(),
        ));
      case RouteManager.settings:
        return PageTransitionManager.materialSlideTransition(
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AuthStatus(),
              ),
              BlocProvider.value(value: fruitsRepositoryCubit),
              BlocProvider(
                create: (context) => PickImageCubit(),
              ),
            ],
            child: const SettingsScreen(),
          ),
        );
      case RouteManager.archive:
        return PageTransitionManager.materialSlideTransition(
          BlocProvider(
            create: (context) => ArchiveCubit()..fetchInvoices(),
            child: const ArchiveScreen(),
          ),
        );
      default:
        return null;
    }
  }
}
