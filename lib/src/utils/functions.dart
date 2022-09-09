import 'package:flutter/material.dart';
import 'package:get/get.dart';

void openBottomSheet(Widget widget) {
  Get.bottomSheet(
    widget,
    backgroundColor: Colors.transparent,
    elevation: 0,
    barrierColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
}
