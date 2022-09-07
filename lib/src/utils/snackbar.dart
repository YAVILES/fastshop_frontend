import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackBar {
  static error({required String message, String? title}) {
    Get.snackbar(title ?? 'Error', message, backgroundColor: Colors.red);
  }

  static success({required String message, String? title}) {
    Get.snackbar(title ?? 'Success', message,
        backgroundColor: Color.fromARGB(255, 4, 235, 61));
  }
}
