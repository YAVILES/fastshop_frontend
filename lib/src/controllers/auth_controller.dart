import 'package:fastshop/src/models/auth_model.dart';
import 'package:fastshop/src/models/user_model.dart';
import 'package:fastshop/src/providers/auth_provider.dart';
import 'package:fastshop/src/ui/pages/recover.dart';
import 'package:fastshop/src/utils/api.dart';
import 'package:fastshop/src/utils/snackbar.dart';
import 'package:fastshop/src/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../router/pages.dart';

enum Status { notLoggedIn, loggedIn, authenticating, loggedOut }

class AuthController extends GetxController {
  @override
  void onReady() {
    isAuthenticated();
    super.onReady();
  }

  AuthProvider loginProvider = AuthProvider();
  final GlobalKey<FormState> formLoginKey = GlobalKey<FormState>();
  RxString username = "".obs;
  RxString password = "".obs;
  RxString fieldVerify = "".obs;
  RxString schema = "".obs;
  RxString email = "".obs;
  RxString phone = "".obs;
  RxString codeSecurity = "".obs;
  RxBool loading = false.obs;
  RxBool _backButtonActive = true.obs;
  RxBool showMethod = false.obs;
  String pk = "";
  RxString c1 = "".obs;
  RxString c2 = "".obs;
  RxString c3 = "".obs;
  RxString c4 = "".obs;
  RxString recovePassword = "".obs;
  RxString replyRecovePassword = "".obs;

  RxBool get backButtonActive => _backButtonActive;

  set backButtonActive(RxBool backButtonActive) {
    _backButtonActive = backButtonActive;
    update();
  }

  bool validateForm() => formLoginKey.currentState!.validate();
  Rx<Status> get loggedInStatus => Status.notLoggedIn.obs;

  final Rx<UserModel?> _user = UserModel().obs;

  UserModel? get user => _user.value;

  set user(UserModel? user) {
    _user.value = user;
  }

  Future<bool> isAuthenticated() async {
    final token = Storage.getToken();
    if (token == null) {
      return false;
    }
    // loginProvider.onInit();
    final resp = await loginProvider.currentUser();
    if (resp != null) {
      user = resp;
      return true;
    } else {
      return false;
    }
  }

  Future<void> doLogin() async {
    {
      if (loading.isFalse) {
        loading.value = true;
      }
      if (validateForm()) {
        var splitUsername = username.split("@");
        if (splitUsername.length > 1) {
          await Storage.setSchema(splitUsername[1]);
          API.configureDio(null);
          formLoginKey.currentState!.save();
          AuthModel? resp = await loginProvider.login(
              {"username": splitUsername[0], "password": password.value});
          if (resp != null) {
            await Storage.setToken(resp.token, resp.refresh);
            API.configureDio(null);
            user = await loginProvider.currentUser();
            update();
            Get.offAllNamed(Routes.home);
          }
        } else {
          CustomSnackBar.error(message: 'Usuario invalido');
        }
        loading.value = false;
      } else {
        loading.value = false;
      }
    }
  }

  logout() {
    Storage.removetoken();
    user = UserModel();
    update();
    Get.offAndToNamed(Routes.login);
  }

  userVerify() async {
    Map<String, dynamic>? resp = await loginProvider
        .userVerify({"field": fieldVerify.value, "schema": schema.value});
    // print(resp);
    if (resp != null) {
      showMethod.value = true;
      email.value = resp['email'];
      phone.value = resp['phone'] ?? "";
      pk = resp['pk'];

      return resp;
    } else {
      CustomSnackBar.error(message: 'Usuario invalido');
    }
  }

  sendEmail() async {
    Map<String, dynamic>? resp = await loginProvider.sendEmail({
      "field": fieldVerify.value,
      "schema": schema.value,
      "email": email.value,
      "pk": pk
    });
    if (resp != null) {
      // print(resp);
      //codeSecurity.value = resp['code'];
      Get.to(const Second());
      return resp;
    } else {
      CustomSnackBar.error(message: 'Usuario invalido');
    }
  }

  verifyCode() async {
    final code = c1.value + c2.value + c3.value + c4.value;
    Map<String, dynamic>? resp = await loginProvider.validateCode({
      "field": fieldVerify.value,
      "schema": schema.value,
      "pk": pk,
      "code": code
    });
    if (resp != null) {
      if (resp['code'] == '200') {
        CustomSnackBar.success(message: resp['message']);
        Get.to(const Third());
      }
      if (resp['code'] == '400') {
        CustomSnackBar.error(message: resp['message']);
      }
      return resp;
    } else {
      CustomSnackBar.error(message: 'Error');
    }
  }

  changePassword() async {
    Map<String, dynamic>? resp = await loginProvider.changePassword({
      "field": fieldVerify.value,
      "schema": schema.value,
      "pk": pk,
      "password": recovePassword.value
    });
    if (resp != null) {
      // print(resp);
      //codeSecurity.value = resp['code'];
      Get.to(const Four());
      return resp;
    } else {
      CustomSnackBar.error(message: 'Error');
    }
  }
}
