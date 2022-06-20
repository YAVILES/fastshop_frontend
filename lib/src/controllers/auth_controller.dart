import 'package:fastshop/src/models/user_model.dart';
import 'package:fastshop/src/providers/login_provider.dart';
import 'package:fastshop/src/utils/snackbar.dart';
import 'package:fastshop/src/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../router/pages.dart';

enum Status { notLoggedIn, loggedIn, authenticating, loggedOut }

class AuthController extends GetxController {
  LoginProvider loginProvider = LoginProvider();
  final GlobalKey<FormState> formLoginKey = GlobalKey<FormState>();
  RxString username = "".obs;
  RxString password = "".obs;
  RxBool loading = false.obs;
  bool validateForm() => formLoginKey.currentState!.validate();
  Rx<Status> get loggedInStatus => Status.notLoggedIn.obs;

  Rx<UserModel?> user = UserModel().obs;

  Future<bool> isAuthenticated() async {
    final token = Storage.getToken();
    if (token == null) {
      return false;
    }
    final resp = await loginProvider.currentUser();
    if (resp != null) {
      user.value = resp;
      return true;
    } else {
      return false;
    }
  }

  AuthController() {
    isAuthenticated();
  }

  doLogin() async {
    {
      if (loading.isFalse) {
        loading.value = true;
      }
      if (validateForm()) {
        var splitUsername = username.split("@");
        if (splitUsername.length > 1) {
          await Storage.setSchema(splitUsername[1]);
          loginProvider.onInit();
          formLoginKey.currentState!.save();
          final resp = await loginProvider.login(
              {"username": splitUsername[0], "password": password.value});
          if (resp != null) {
            await Storage.setToken(resp['token'], resp['refresh']);
            loginProvider.onInit();
            user.value = await loginProvider.currentUser();
            Get.offAllNamed(Routes.home);
          } else {
            CustomSnackBar.error('Error', '');
          }
        } else {
          CustomSnackBar.error('Error', 'Usuario invalido');
        }
        loading.value = false;
      } else {
        loading.value = false;
      }
    }
  }
}
