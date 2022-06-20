import 'package:flutter/material.dart';

class CustomButtonSecundary extends Container {
  final Function function;
  final String text;
  @override
  // ignore: overridden_fields
  final Color color;
  final Color textColor;
  final Color splashColor;
  final double fontSize;

  CustomButtonSecundary({
    Key? key,
    required this.function,
    required this.text,
    this.splashColor = Colors.blueGrey,
    this.fontSize = 16,
    this.color = Colors.blue,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      splashColor: splashColor,
      onPressed: () => function(),
      color: color,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
