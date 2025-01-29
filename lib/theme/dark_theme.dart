import 'package:flutter/material.dart';

class DarkTheme {
  static ThemeData theme = ThemeData(
    primarySwatch: Colors.pink,
    brightness: Brightness.dark,
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
      bodyText1: TextStyle(fontSize: 16.0, color: Colors.white70),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.pink,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}