import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_task_calculator/utils/constant.dart';

class ThemesMode {
  static bool isDarkMode;

  void init(BuildContext context) {
    isDarkMode = Theme.of(context).brightness == Brightness.dark;
    SystemChrome.setSystemUIOverlayStyle(ThemesMode.isDarkMode
        ? SystemUiOverlayStyle(
            systemNavigationBarColor: backgroundDark,
            systemNavigationBarIconBrightness: Brightness.light,
            statusBarColor: textBlack,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
          )
        : SystemUiOverlayStyle(
            systemNavigationBarColor: backgroundLight,
            systemNavigationBarIconBrightness: Brightness.dark,
            statusBarColor: textWhite,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
          ));
  }
}

