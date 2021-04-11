import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_task_calculator/utils/constant.dart';



class AppTheme {
  ThemeData darkTheme() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return ThemeData(
      scaffoldBackgroundColor: backgroundDark,
      //backgroundColor: AppColors.backgroundDark,
      primarySwatch: Colors.grey,
      primaryColor: backgroundDark,
      inputDecorationTheme: InputDecorationTheme(
        //hintStyle: TextStyle(color: textGrey),
        labelStyle: TextStyle(color: textWhite),
      ),
      brightness: Brightness.dark,
      canvasColor: backgroundDark,
      accentColor: textBlue,
      dividerTheme: DividerThemeData(
        color: Colors.grey,
        thickness: 0.2,
      ),
      appBarTheme: AppBarTheme(
        elevation: 2,
       color: Color(0xff131313)
      ),
      accentIconTheme: IconThemeData(color: Colors.white),
    );
  }

  ThemeData lightTheme() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return ThemeData(
      scaffoldBackgroundColor: backgroundLight,
      //backgroundColor: AppColors.backgroundLight,
      primarySwatch: Colors.grey,
      primaryColor: backgroundLight,
      inputDecorationTheme: InputDecorationTheme(
        //hintStyle: TextStyle(color: textGrey),
        labelStyle: TextStyle(color: textBlack),
      ),
      canvasColor: textWhite,
      brightness: Brightness.light,
      //accentColor: introGrey,
      dividerTheme: DividerThemeData(
        color: Colors.grey,
        thickness: 0.2,
      ),
      appBarTheme: AppBarTheme(
        elevation: 2,
        //color: textWhite
      ),
      accentIconTheme: IconThemeData(color: Colors.black),
    );
  }

}
