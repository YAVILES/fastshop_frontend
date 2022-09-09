import 'package:get/get.dart';

class NavigationController extends GetxController {
  RxInt activeIndex = 0.obs;
  RxList permissions = [].obs;
  RxMap currentModule = {}.obs;
}
