import 'package:fastshop/src/middlewares/auth_guard.dart';
import 'package:fastshop/src/ui/pages/home_page.dart';
import 'package:fastshop/src/ui/pages/login_page.dart';
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
          transition: Transition.zoom,
        ),
        GetPage(
          name: Routes.inventory,
          page: () => const MyHomePage(title: "Inventario"),
          transition: Transition.zoom,
        ),
        GetPage(
          name: Routes.sales,
          page: () => const MyHomePage(title: "Ventas"),
          transition: Transition.zoom,
        ),
      ],
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      transition: Transition.zoom,
    ),
  ];
}
