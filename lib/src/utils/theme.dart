import 'package:flutter/material.dart';

const primaryColor = Colors.blueAccent;

final ThemeData appThemeData = ThemeData(
  primaryColor: primaryColor,
  fontFamily: 'Georgia',
  textTheme: const TextTheme(
    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide(width: 0.4),
    ),
  ),
);
