import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sudoku/size_extension.dart';

const String fontFamily = 'Summary Notes';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Color(0xFFFFD72E),
    fontFamily: fontFamily,
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
      fontFamily: fontFamily,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Color(0xFFFFD72E),
    fontFamily: fontFamily,
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
      fontFamily: fontFamily,
    ),
  );
}
