import 'package:fastshop/src/router/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  String routeBase = Routes.inventory;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        GestureDetector(
          onTap: () => Get.toNamed('$routeBase${Routes.category}'),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: const [
                Icon(
                  Icons.category_rounded,
                  size: 50,
                ),
                Text(
                  'Categorías',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
