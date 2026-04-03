import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/core/utils/app_styles.dart';

abstract class AppThems {
  static ThemeData appThems() {
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
        titleTextStyle: TextStyle(
          color: AppStyle.whiteColor,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
    );
  }
}
