import 'package:fastshop/src/controllers/configuration_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // ConfigurationController configurationController =
  //     Get.put(ConfigurationController());
  @override
  Widget build(BuildContext context) {
    // Map<String, dynamic> configurationMap =
    //     configurationController.configuration.value!.toMap();
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 25),
                        child: Image.asset(
                          "assets/images/logo.webp",
                          height: 180,
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Moneda Principal:",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              DropdownButton<String>(
                                icon: const Icon(Icons.monetization_on),
                                items: const [
                                  DropdownMenuItem(
                                    value: "VEF",
                                    child: Text("Bolívar"),
                                  ),
                                  DropdownMenuItem(
                                    value: "USD",
                                    child: Text("Dólar"),
                                  )
                                ],
                                onChanged: (Object? value) {},
                              )
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Moneda para Facturas:",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              DropdownButton<String>(
                                icon: const Icon(Icons.monetization_on),
                                items: const [
                                  DropdownMenuItem(
                                    value: "VEF",
                                    child: Text("Bolívar"),
                                  ),
                                  DropdownMenuItem(
                                    value: "USD",
                                    child: Text("Dólar"),
                                  )
                                ],
                                onChanged: (Object? value) {},
                              )
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                flex: 2,
                                child: Text(
                                  "Nro. Inicial de Pedidos:",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  textAlign: TextAlign.end,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {},
                                  onSaved: (value) {},
                                  initialValue: "1",
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "EL usuario es requerido";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                flex: 2,
                                child: Text(
                                  "Nro. actual de Pedidos:",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  textAlign: TextAlign.end,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {},
                                  onSaved: (value) {},
                                  initialValue: "1",
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "EL usuario es requerido";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                flex: 2,
                                child: Text(
                                  "Nro. Inicial de Facturas:",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  textAlign: TextAlign.end,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {},
                                  onSaved: (value) {},
                                  initialValue: "1",
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "EL usuario es requerido";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                flex: 2,
                                child: Text(
                                  "% I.V.A:",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  textAlign: TextAlign.end,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {},
                                  onSaved: (value) {},
                                  initialValue: "10",
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "EL usuario es requerido";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            ElevatedButton(
              style: const ButtonStyle(),
              child: const Text("GUARDAR"),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
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
