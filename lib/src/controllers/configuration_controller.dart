import 'package:fastshop/src/models/configuration_model.dart';
import 'package:fastshop/src/providers/configuration_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfigurationController extends GetxController {
  Rx<ConfigurationModel?> configuration = null.obs;
  RxBool saving = false.obs;
  final GlobalKey<FormState> formConfigurationkey = GlobalKey<FormState>();
  ConfigurationProvider configurationProvider = ConfigurationProvider();

  @override
  Future<void> onReady() async {
    configuration.value = await configurationProvider.getConfiguration({});
    super.onReady();
  }

  Future<void> saveCategory() async {
    if (saving.isFalse) {
      saving.value = true;
    }
    if (formConfigurationkey.currentState!.validate()) {
      final resp = await configurationProvider
          .saveConfiguration(configuration.value!.toMap());
      if (resp != null) {
        update();
      }
      saving.value = false;
    } else {
      saving.value = false;
    }
  }
}
