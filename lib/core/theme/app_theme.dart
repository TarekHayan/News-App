import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_styles.dart';

abstract final class AppTheme {
  static ThemeData materialTheme() {
    return ThemeData(
      scaffoldBackgroundColor: AppStyle.blackColor,
      appBarTheme: AppBarTheme(
        foregroundColor: AppStyle.whiteColor,
        elevation: 0,
        backgroundColor: AppStyle.blackColor,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppStyle.whiteColor,
        ),
        titleTextStyle: const TextStyle(
          color: AppStyle.whiteColor,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
    );
  }
}
