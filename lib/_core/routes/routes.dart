import 'package:get/get.dart';
import 'package:tmdp_getx_mvc/_core/routes/app_routes.dart';
import 'package:tmdp_getx_mvc/view/auth/auth.dart';
import 'package:tmdp_getx_mvc/view/dash_board/dash_board.dart';

import '../../view/splash/splash_screen.dart';

class Routes {
  static List<GetPage> getRoutes() {
    return [
      GetPage(
        name: AppRoutes.splashScreen,
        page: () => const SplashScreen(),
      ),
      GetPage(
        name: AppRoutes.auth,
        page: () => const AuthPage(),
      ),
      GetPage(
        name: AppRoutes.dashBoard,
        page: () => const DashBoardPage(),
      ),
    ];
  }
}
