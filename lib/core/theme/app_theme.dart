import 'package:e_commerce_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static ThemeData lightthem = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColor.lightmode,
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColor.lightmode,
    ),
    appBarTheme: AppBarTheme(backgroundColor: AppColor.lightmode),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColor.lightmode,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: AppColor.bordercolor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: AppColor.secondarycolor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: AppColor.bordercolor),
      ),
    ),
    fontFamily: 'Poppins',
    textTheme: TextTheme(
      headlineMedium: TextStyle(fontSize: 30.sp, fontWeight: FontWeight(900)),
      titleLarge: TextStyle(fontSize: 20.sp, fontWeight: FontWeight(500)),
      titleMedium: TextStyle(fontSize: 18.sp, fontWeight: FontWeight(400)),
      titleSmall: TextStyle(fontSize: 15.sp, fontWeight: FontWeight(400)),
    ),
  );
  static ThemeData darkthem = ThemeData(
    brightness: Brightness.dark,
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColor.darkmode,
    ),
    scaffoldBackgroundColor: AppColor.darkmode,
    appBarTheme: AppBarTheme(backgroundColor: AppColor.darkmode),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColor.lightmode,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: AppColor.bordercolor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: AppColor.secondarycolor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: AppColor.bordercolor),
      ),
    ),
    fontFamily: 'Poppins',
    textTheme: TextTheme(
      headlineMedium: TextStyle(fontSize: 30.sp, fontWeight: FontWeight(900)),
      titleLarge: TextStyle(fontSize: 20.sp, fontWeight: FontWeight(500)),
      titleMedium: TextStyle(fontSize: 18.sp, fontWeight: FontWeight(400)),
      titleSmall: TextStyle(fontSize: 15.sp, fontWeight: FontWeight(400)),
    ),
  );
}
