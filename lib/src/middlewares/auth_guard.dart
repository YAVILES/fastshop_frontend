import 'package:fastshop/src/controllers/auth_controller.dart';
import 'package:fastshop/src/router/pages.dart';
import 'package:fastshop/src/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthGuard extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    var token = Storage.getToken();
    if (token == null) {
      return const RouteSettings(name: Routes.login);
    }
    if (route == Routes.login) {
      return const RouteSettings(name: Routes.home);
    }
    return null;
  }
}
