import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackBar {
  static error({required String message, String? title}) {
    Get.snackbar(title ?? 'Error', message, backgroundColor: Colors.red);
  }
}
