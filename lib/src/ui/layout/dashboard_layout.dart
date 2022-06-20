import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:fastshop/src/router/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashBoardLayout extends StatefulWidget {
  const DashBoardLayout({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  State<DashBoardLayout> createState() => _DashBoardLayoutState();
}

class _DashBoardLayoutState extends State<DashBoardLayout> {
  @override
  Widget build(BuildContext context) {
    return Overlay(
      initialEntries: [
        OverlayEntry(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('FastShop'),
                actions: const [],
              ),
              backgroundColor: Colors.white,
              body: widget.child,
              bottomNavigationBar: ConvexAppBar(
                items: const [
                  TabItem(icon: Icons.home, title: 'Inicio'),
                  TabItem(icon: Icons.map, title: 'Inventario'),
                  TabItem(icon: Icons.add, title: 'Ventas'),
                ],
                initialActiveIndex: 0, //optional, default as 0
                onTap: (int i) {
                  switch (i) {
                    case 0:
                      Get.toNamed(Routes.home);
                      break;
                    case 1:
                      Get.toNamed(Routes.inventory);
                      break;
                    case 2:
                      Get.toNamed(Routes.sales);
                      break;
                    default:
                  }
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
