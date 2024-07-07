import 'package:akadomen/router/app_router.dart';
import 'package:akadomen/utils/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) => MaterialApp(
              builder: (context, widget) {
                final mediaQueryData = MediaQuery.of(context);
                final scaledMediaQueryData = mediaQueryData.copyWith(
                  textScaler: TextScaler.noScaling,
                );
                return MediaQuery(
                  data: scaledMediaQueryData,
                  child: widget!,
                );
              },
              theme: ThemeData(fontFamily: 'Poppins'),
              title: 'akadomen',
              debugShowCheckedModeBanner: false,
              initialRoute: RouteManager.initialRoute,
              onGenerateRoute: AppRouter.onGenerateRoute,
            ));
  }
}
