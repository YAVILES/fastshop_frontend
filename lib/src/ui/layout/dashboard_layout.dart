import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:fastshop/src/controllers/auth_controller.dart';
import 'package:fastshop/src/controllers/navigation_controller.dart';
import 'package:fastshop/src/router/pages.dart';
import 'package:fastshop/src/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart';

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
        bottomNavigationBar: GetX<NavigationController>(
          init: NavigationController(),
          initState: (_) {},
          builder: (controller) {
            final modulos = groupBy(
                controller.permissions.value,
                (dynamic oj) =>
                    oj['workflow_display']['module_display']['code']);
            return ConvexAppBar(
              top: 0,
              curveSize: 0,
              // activeColor: Colors.black,
              items: [
                const TabItem(icon: Icons.home, title: 'Home'),
                ...modulos.keys.map(
                  (key) => TabItem(
                      icon: Icons.home,
                      title: modulos[key]![0]['workflow_display']
                          ['module_display']['title']),
                ),
              ],
              initialActiveIndex:
                  controller.activeIndex.value, //optional, default as 0
              onTap: (int i) {
                if (Get.isBottomSheetOpen == true) {
                  Get.back();
                  return;
                }
                if (i > 0) {
                  final key = modulos.keys.toList()[i - 1];
                  controller.activeIndex.value = i;
                  // navigationController.currentModule.value = modulos[i]
                  openBottomSheet(Card(
                    elevation: 9,
                    color: Colors.white,
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      alignment: WrapAlignment.spaceAround,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        ...modulos[key]!.map(
                          (m) => GestureDetector(
                            onTap: () {
                              Get.back();
                              Get.toNamed(m["workflow_display"]["url"]);
                            },
                            child: Card(
                              elevation: 0,
                              child: SizedBox(
                                width: 80,
                                child: Center(
                                  child: Column(
                                    children: [
                                      Icon(
                                        iconDataMenuWorkflow(
                                            m["workflow_display"]["icon"]),
                                      ),
                                      Text(m["workflow_display"]['title']),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ));
                } else {
                  Get.toNamed(Routes.home);
                  controller.activeIndex.value = 0;
                }
              },
            );
          },
        ),
      ),
    );
  }
}
