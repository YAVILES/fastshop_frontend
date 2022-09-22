import 'package:fastshop/src/models/brand_model.dart';
import 'package:fastshop/src/providers/brand_provider.dart';
import 'package:fastshop/src/router/pages.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandController extends GetxController {
  Rx<BrandModel?> brand = BrandModel().obs;
  RxBool saving = false.obs;
  final GlobalKey<FormState> formBrandKey = GlobalKey<FormState>();
  BrandProvider categoryProvider = BrandProvider();

  Future<void> saveBrand() async {
    if (saving.isFalse) {
      saving.value = true;
    }
    if (formBrandKey.currentState!.validate()) {
      final resp = await categoryProvider.saveBrand(brand.value!);
      if (resp != null) {
        brand.value = BrandModel();

        Get.toNamed('${Routes.inventory}${Routes.brand}');
        update();
      }
      saving.value = false;
    } else {
      saving.value = false;
    }
  }

  Future<bool> getBrand(String id) async {
    final resp = await categoryProvider.getBrand(id);
    if (resp != null) {
      brand.value = resp;
      return true;
    }
    return false;
  }

  uploadImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      brand.value!.image = result.files.first;
      update();
    } else {
      // Adviser canceled the picker
    }
  }
}
