import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:fastshop/src/router/pages.dart';
import 'package:fastshop/src/ui/widgets/buttons/custom_button_primary.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('FastShop'),
        actions: [
          CustomButtonPrimary(
            function: () {
              Get.snackbar('TEST', 'context');
            },
            text: "TEST",
          ),
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              // popupmenu item 1
              PopupMenuItem(
                value: 1,
                // row has two child icon and text.
                child: Row(
                  children: [
                    Icon(Icons.star),
                    SizedBox(
                      // sized box with width 10
                      width: 10,
                    ),
                    Text("Get The App")
                  ],
                ),
              ),
              // popupmenu item 2
              PopupMenuItem(
                value: 2,
                // row has two child icon and text
                child: Row(
                  children: [
                    Icon(Icons.chrome_reader_mode),
                    SizedBox(
                      // sized box with width 10
                      width: 10,
                    ),
                    Text("About")
                  ],
                ),
              ),
            ],
            offset: Offset(0, 100),
            color: Colors.grey,
            elevation: 2,
          )
        ],
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
  }
}
