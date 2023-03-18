import 'package:fastshop/src/controllers/configuration_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  ConfigurationController configurationController =
      Get.put(ConfigurationController());
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> configurationMap =
        configurationController.configuration.value!.toMap();
    return ListView.builder(
      itemBuilder: (context, index) => ItemConfiguration(
        title: 'Número inicial de asignados',
        value: 1,
      ),
      itemCount: configurationMap.keys.length,
    );
  }
}

class ItemConfiguration extends StatefulWidget {
  ItemConfiguration(
      {super.key, required this.title, required this.value, open = false});

  String title;
  dynamic value;
  bool? open;

  @override
  State<ItemConfiguration> createState() => _ItemConfigurationState();
}

class _ItemConfigurationState extends State<ItemConfiguration> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Text(widget.title),
          const Icon(Icons.arrow_right),
        ],
      ),
    );
  }
}
