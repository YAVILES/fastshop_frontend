import 'package:fastshop/src/middlewares/auth_guard.dart';
import 'package:fastshop/src/ui/pages/configuration/configuration_page.dart';
import 'package:fastshop/src/ui/pages/home_page.dart';
import 'package:fastshop/src/ui/pages/inventory/category/category_edit_page.dart';
import 'package:fastshop/src/ui/pages/inventory/category/category_page.dart';
import 'package:fastshop/src/ui/pages/inventory/inventory_page.dart';
import 'package:fastshop/src/ui/pages/login_page.dart';
import 'package:fastshop/src/ui/pages/recover.dart';
import 'package:fastshop/src/ui/widgets/splash_view.dart';
import 'package:get/get.dart';

part './routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.initial,
      middlewares: [
        AuthGuard(),
      ],
      page: () => const SplashView(),
      children: [
        GetPage(
          name: Routes.home,
          page: () => const MyHomePage(title: "Home"),
        ),
        GetPage(
          name: Routes.inventory,
          page: () => const InventoryPage(),
          children: [
            GetPage(
              name: Routes.category,
              page: () => const CategoryPage(),
            ),
            GetPage(
              name: Routes.categoryEdit,
              page: () => const CategoryEditPage(),
            ),
          ],
        ),
        GetPage(
          name: Routes.sales,
          page: () => const MyHomePage(title: "Ventas"),
        ),
        GetPage(
          name: Routes.configuration,
          page: () => const ConfigurationPage(),
        ),
      ],
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: Routes.recoverpass,
      page: () => const RecoverPage(),
      transition: Transition.zoom,
    )
  ];
}
