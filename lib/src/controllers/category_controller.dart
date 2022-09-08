import 'package:fastshop/src/models/category_model.dart';
import 'package:fastshop/src/providers/category_provider.dart';
import 'package:fastshop/src/router/pages.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  Rx<CategoryModel?> category = CategoryModel().obs;
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
        Get.toNamed('${Routes.inventory}${Routes.category}');
        update();
      }
      saving.value = false;
    } else {
      saving.value = false;
    }
  }

  Future<bool> getCategory(String id) async {
    final resp = await categoryProvider.getCategory(id);
    if (resp != null) {
      category.value = resp;
      return true;
    }
    return false;
  }

  uploadImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      category.value!.image = result.files.first;
      update();
    } else {
      // Adviser canceled the picker
    }
  }
}
