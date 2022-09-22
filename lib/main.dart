import 'package:fastshop/src/app.dart';
import 'package:fastshop/src/controllers/auth_controller.dart';
import 'package:fastshop/src/controllers/brand_controller.dart';
import 'package:fastshop/src/controllers/category_controller.dart';
import 'package:fastshop/src/controllers/navigation_controller.dart';
import 'package:fastshop/src/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Storage.configureStorage();
  Get.lazyPut(() => NavigationController());
  Get.lazyPut(() => AuthController());
  Get.lazyPut(() => CategoryController());
  Get.lazyPut(() => BrandController());

  runApp(const MyApp());
}
