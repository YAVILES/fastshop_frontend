import 'package:fastshop/src/router/pages.dart';
import 'package:fastshop/src/utils/storage.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    final token = Storage.getToken();
    if (token != null) {
      Future.delayed(
          const Duration(seconds: 2), () => Get.toNamed(Routes.home));
    } else {
      Future.delayed(
          const Duration(seconds: 3), () => Get.toNamed(Routes.login));
    }
    super.onReady();
  }
}
