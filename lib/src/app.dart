import 'package:fastshop/src/controllers/auth_controller.dart';
import 'package:fastshop/src/router/pages.dart';
import 'package:fastshop/src/ui/layout/auth_layout.dart';
import 'package:fastshop/src/ui/layout/dashboard_layout.dart';
import 'package:fastshop/src/utils/api.dart';
import 'package:fastshop/src/utils/storage.dart';
import 'package:fastshop/src/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    API.configureDio(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FastShop',
      theme: appThemeData,
      initialRoute: Routes.initial,
      getPages: AppPages.pages,
      builder: (context, child) {
        bool backButtonActive =
            Get.find<AuthController>().backButtonActive.value;
        return GetBuilder<AuthController>(builder: (context) {
          return (Storage.getToken() == null)
              ? AuthLayout(backButtonActive: backButtonActive, child: child!)
              : Overlay(
                  initialEntries: [
                    OverlayEntry(
                      builder: (context) => DashBoardLayout(child: child!),
                    )
                  ],
                );
        });
      },
    );
  }
}
