import 'package:fastshop/src/controllers/auth_controller.dart';
import 'package:fastshop/src/router/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthLayout extends StatefulWidget {
  const AuthLayout(
      {Key? key, required this.child, required this.backButtonActive})
      : super(key: key);
  final Widget child;
  final bool backButtonActive;

  @override
  State<AuthLayout> createState() => _AuthLayoutState();
}

class _AuthLayoutState extends State<AuthLayout> {
  AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            leading: widget.backButtonActive == true
                ? const SizedBox()
                : IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Get.offAllNamed(Routes.login);
                    },
                  )),
        body: widget.child);
  }
}
