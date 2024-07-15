import 'dart:io';
import 'package:akadomen/app.dart';
import 'package:akadomen/utils/helpers/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:window_manager/window_manager.dart';
import 'database/sql.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CacheData.cacheDataInit();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      size: Size(1280, 800),
      center: true,
      backgroundColor: Colors.transparent,
      title: 'Akadomen',
      titleBarStyle: TitleBarStyle.normal,
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
      await windowManager.setResizable(true);
      await windowManager.setMinimumSize(const Size(1024, 768));
    });
  }
  await SqlDb().initializeDatabase();
  runApp(const MyApp());
}
