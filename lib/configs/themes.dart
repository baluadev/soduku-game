import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sudoku/configs/const.dart';
import 'package:sudoku/size_extension.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xFFFFFFFF),
    primaryColor: Color(0xFFFFD72E),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFFFFD72E),
      onPrimary: Color(0xFFFFD72E),
      secondary: Colors.black,
      onSecondary: Colors.black,
      error: Colors.red,
      onError: Colors.red,
      background: Color(0xFFEAEAEA),
      onBackground: Color(0xFFEAEAEA),
      surface: Colors.black,
      onSurface: Colors.black,
    ),
    fontFamily: fontSummary,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 30.r,
        color: Colors.black,
      ),
      titleMedium: TextStyle(
        fontSize: 12.r,
        color: Colors.black,
      ),
      titleSmall: TextStyle(
        fontSize: 12.r,
        color: Colors.black,
      ),
    ).apply(
      fontFamily: fontSummary,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Color(0xFFFFD72E),
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFFFD72E),
      onPrimary: Color(0xFFFFD72E),
      secondary: Colors.white,
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.red,
      background: Color.fromARGB(255, 33, 33, 33),
      onBackground: Color.fromARGB(255, 33, 33, 33),
      surface: Colors.black,
      onSurface: Colors.black,
    ),
    fontFamily: fontSummary,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 30.r,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontSize: 12.r,
        color: Colors.white,
      ),
      titleSmall: TextStyle(
        fontSize: 12.r,
        color: Colors.white,
      ),
    ).apply(
      fontFamily: fontSummary,
    ),
  );
}
