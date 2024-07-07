import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

abstract class AppTheme {
  //? LIGHT THEME
  static ThemeData get lightTheme {
    return ThemeData(
      switchTheme: const SwitchThemeData(
        trackOutlineColor: WidgetStatePropertyAll(ColorManager.black),
        thumbColor: WidgetStatePropertyAll(ColorManager.black),
        trackColor: WidgetStatePropertyAll(ColorManager.white),
        thumbIcon: WidgetStatePropertyAll(
          Icon(
            Icons.light_mode,
            color: ColorManager.white,
          ),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: ColorManager.brown,
        selectionColor: ColorManager.brown.withOpacity(0.3),
        selectionHandleColor: ColorManager.brown,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: ColorManager.white,
          textStyle: TextStyle(
              fontSize: 16.spMin,
              color: ColorManager.white,
              fontWeight: FontWeight.w500),
          overlayColor: ColorManager.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
          backgroundColor: ColorManager.brown,
          fixedSize: const Size(double.maxFinite, 54),
        ),
      ),
      iconTheme: const IconThemeData(color: ColorManager.black),
      fontFamily: 'Poppins',
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: ColorManager.darkGrey,
      appBarTheme: AppBarTheme(
        elevation: BorderSide.strokeAlignOutside,
        backgroundColor: ColorManager.brown,
        shadowColor: ColorManager.darkGrey,
        centerTitle: false,
        iconTheme: const IconThemeData(color: ColorManager.black),
        titleTextStyle: TextStyle(
            color: ColorManager.black,
            fontSize: 20.spMin,
            fontWeight: FontWeight.w600),
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(
            fontSize: 32.spMin,
            color: ColorManager.brown,
            fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(
            fontSize: 16.spMin,
            color: ColorManager.brown,
            fontWeight: FontWeight.w500),
        bodySmall: TextStyle(
          fontSize: 22.spMin,
          fontWeight: FontWeight.w500,
          color: ColorManager.white,
        ),
        displayMedium: TextStyle(
            fontSize: 16.spMin,
            color: ColorManager.grey,
            fontWeight: FontWeight.w500),
      ),
      inputDecorationTheme: InputDecorationTheme(
        isCollapsed: true,
        isDense: true,
        errorStyle: const TextStyle(fontSize: 16, color: ColorManager.error),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: ColorManager.error,
                width: 2,
                strokeAlign: BorderSide.strokeAlignCenter)),
        focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: ColorManager.error,
                width: 2,
                strokeAlign: BorderSide.strokeAlignCenter)),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
        filled: true,
        fillColor: ColorManager.white,
      ),
    );
  }
}
