import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackBar {
  static error(title, message) {
    Get.snackbar(title, message, backgroundColor: Colors.red);
  }
}
