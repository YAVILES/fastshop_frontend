import 'package:flutter/material.dart';

const primaryColor = Colors.blueAccent;

final ThemeData appThemeData = ThemeData(
  primaryColor: primaryColor,
  fontFamily: 'Georgia',
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide(width: 0.4),
    ),
  ),
);
