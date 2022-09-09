import 'package:fastshop/src/controllers/auth_controller.dart';
import 'package:fastshop/src/controllers/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AuthController authController = Get.find<AuthController>();
  NavigationController navigationController = Get.find<NavigationController>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.title),
          Obx(() => Text('Bienvenido ${authController.user?.fullName}'))
        ],
      ),
    );
  }
}
