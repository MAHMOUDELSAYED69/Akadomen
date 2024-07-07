import 'package:akadomen/router/app_router.dart';
import 'package:akadomen/utils/constants/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Akadomen',
      debugShowCheckedModeBanner: false,
      initialRoute: RouteManager.initialRoute,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
