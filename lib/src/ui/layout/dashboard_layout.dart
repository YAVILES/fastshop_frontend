import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:fastshop/src/controllers/auth_controller.dart';
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
    final authController = Get.find<AuthController>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('FastShop'),
          actions: [
            PopupMenuButton<int>(
              onSelected: (value) {
                if (value == 1) {
                  authController.logout();
                }
              },
              itemBuilder: (context) {
                return [
                  // popupmenu item 1
                  PopupMenuItem(
                    value: 1,
                    // row has two child icon and text.
                    child: Row(
                      children: const [
                        Icon(Icons.logout),
                        SizedBox(
                          // sized box with width 10
                          width: 10,
                        ),
                        Text("Cerrar sesión")
                      ],
                    ),
                  ),
                ];
              },
              offset: const Offset(0, 60),
              color: Colors.grey,
              elevation: 2,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: widget.child,
        ),
        bottomNavigationBar: ConvexAppBar(
          items: const [
            TabItem(icon: Icons.home, title: 'Inicio'),
            TabItem(icon: Icons.map, title: 'Inventario'),
            TabItem(icon: Icons.account_balance, title: 'Cuentas'),
            TabItem(icon: Icons.settings, title: 'Configuración'),
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
              case 3:
                Get.toNamed(Routes.configuration);
                break;
              default:
            }
          },
        ),
      ),
    );
  }
}
