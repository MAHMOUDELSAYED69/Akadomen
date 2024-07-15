import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

abstract class AppTheme {
  //? LIGHT THEME
  static ThemeData get lightTheme {
    return ThemeData(
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          overlayColor: const WidgetStatePropertyAll(ColorManager.white),
          backgroundColor: WidgetStatePropertyAll(
            ColorManager.white.withOpacity(0.7),
          ),
        ),
      ),
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
          elevation: 4,
          textStyle: TextStyle(
              fontSize: 22.spMin,
              color: ColorManager.white,
              fontWeight: FontWeight.w500),
          overlayColor: ColorManager.error,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          backgroundColor: ColorManager.brown,
          fixedSize: Size(double.maxFinite, 54.h),
        ),
      ),
      iconTheme: IconThemeData(color: ColorManager.brown, size: 7.sp),
      fontFamily: 'Poppins',
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: ColorManager.brown,
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
            fontSize: 5.sp,
            color: ColorManager.brown,
            fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(
          fontSize: 4.sp,
          fontWeight: FontWeight.w500,
          color: ColorManager.white,
        ),
        bodySmall: TextStyle(
            fontSize: 14.spMin,
            color: ColorManager.brown,
            fontWeight: FontWeight.w500),
        displaySmall: TextStyle(
            fontSize: 14.spMin,
            color: ColorManager.white,
            fontWeight: FontWeight.w500),
        displayMedium: TextStyle(
            fontSize: 4.sp,
            color: ColorManager.brown,
            fontWeight: FontWeight.w500),
      ),
      inputDecorationTheme: InputDecorationTheme(
        isCollapsed: true,
        isDense: true,
        errorStyle: TextStyle(
            fontSize: 12.spMin, color: ColorManager.error, height: 0.5),
        hintStyle: TextStyle(fontSize: 12.spMin, color: ColorManager.grey),
        fillColor: ColorManager.white,
        filled: true,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          borderSide: BorderSide(
            width: 1.4,
            color: ColorManager.brown,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          borderSide: BorderSide(
            width: 1.4,
            color: ColorManager.brown,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          borderSide: BorderSide(
            width: 1.4,
            color: ColorManager.error,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          borderSide: BorderSide(
            width: 1.4,
            color: ColorManager.error,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 10),
      ),
    );
  }
}
