import 'package:fastshop/src/models/category_model.dart';
import 'package:fastshop/src/providers/category_provider.dart';
import 'package:fastshop/src/router/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  Rx<CategoryModel?> category = null.obs;
  RxBool saving = false.obs;
  final GlobalKey<FormState> formCategoryKey = GlobalKey<FormState>();
  CategoryProvider categoryProvider = CategoryProvider();

  Future<void> saveCategory() async {
    if (saving.isFalse) {
      saving.value = true;
    }
    if (formCategoryKey.currentState!.validate()) {
      final resp = await categoryProvider.saveCategory(category.value!);
      if (resp != null) {
        update();
        Get.toNamed('${Routes.inventory}${Routes.category}');
      }
      saving.value = false;
    } else {
      saving.value = false;
    }
  }
}
