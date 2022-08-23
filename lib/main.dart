import 'package:fastshop/src/app.dart';
import 'package:fastshop/src/controllers/auth_controller.dart';
import 'package:fastshop/src/utils/api.dart';
import 'package:fastshop/src/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Storage.configureStorage();
  Get.put(API());
  Get.lazyPut(() => AuthController());
  runApp(const MyApp());
}
