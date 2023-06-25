import 'package:flutter/material.dart';
import 'package:sekrut/core/ui/app_color.dart';
import 'package:sekrut/generated/fonts.gen.dart';

abstract class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColor.black,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: AppColor.black,
        fontFamily: FontFamily.hk,
        fontWeight: FontWeight.bold,
        fontSize: 32,
      ),
      headlineSmall: TextStyle(
        color: AppColor.black,
        fontFamily: FontFamily.hk,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      titleLarge: TextStyle(
        color: AppColor.black,
        fontFamily: FontFamily.hk,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      titleMedium: TextStyle(
        color: AppColor.black,
        fontFamily: FontFamily.hk,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      titleSmall: TextStyle(
        color: AppColor.black,
        fontFamily: FontFamily.hk,
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
      bodyLarge: TextStyle(
        color: AppColor.black,
        fontFamily: FontFamily.hk,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
      bodyMedium: TextStyle(
        color: AppColor.black,
        fontFamily: FontFamily.hk,
        fontWeight: FontWeight.normal,
        fontSize: 12,
      ),
    ),
    canvasColor: AppColor.white,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColor.black,
      onPrimary: AppColor.white,
      secondary: AppColor.secondary,
      onSecondary: AppColor.white,
      error: Colors.red,
      onError: AppColor.white,
      background: AppColor.dark,
      onBackground: AppColor.white,
      surface: AppColor.white,
      onSurface: AppColor.black,
      tertiary: AppColor.gray,
      outline: AppColor.altLight.withOpacity(0.5),
    ),
  );
}
