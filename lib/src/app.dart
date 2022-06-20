import 'package:fastshop/src/router/pages.dart';
import 'package:fastshop/src/ui/layout/auth_layout.dart';
import 'package:fastshop/src/ui/layout/dashboard_layout.dart';
import 'package:fastshop/src/ui/pages/home_page.dart';
import 'package:fastshop/src/utils/storage.dart';
import 'package:fastshop/src/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FastShop',
      theme: appThemeData,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: Routes.initial,
      getPages: AppPages.pages,
      builder: (context, child) {
        return (Storage.getToken() == null || Get.currentRoute == Routes.login)
            ? AuthLayout(child: child!)
            : DashBoardLayout(child: child!);
      },
    );
  }
}
