import 'package:flutter/material.dart';

class LightTheme {
  static ThemeData theme = ThemeData(
    primarySwatch: Colors.pink,
    brightness: Brightness.light,
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),
      bodyText1: TextStyle(fontSize: 16.0, color: Colors.black87),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.pink,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}