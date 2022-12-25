import 'package:get/get.dart';
import 'package:tmdp_getx_mvc/_core/routes/app_routes.dart';

import '../../view/splash/splash_screen.dart';

class Routes {
  static List<GetPage> getRoutes() {
    GetPage(
      name: AppRoutes.splashScreen,
      page: () => const SplashScreen(),
    );
    return [];
  }
}
