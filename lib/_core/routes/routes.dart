import 'package:get/get.dart';
import 'package:tmdp_getx_mvc/_core/routes/app_routes.dart';
import 'package:tmdp_getx_mvc/view/auth/auth_page.dart';
import 'package:tmdp_getx_mvc/view/dash_board/dash_board_page.dart';
import 'package:tmdp_getx_mvc/view/dash_board/pages/item_lists_page.dart';
import 'package:tmdp_getx_mvc/view/home/home_page.dart';
import 'package:tmdp_getx_mvc/view/profile/profile_page.dart';
import 'package:tmdp_getx_mvc/view/watch_list/watch_list_page.dart';

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
      GetPage(
        name: AppRoutes.watchList,
        page: () => const WatchListPage(),
      ),
      GetPage(
        name: AppRoutes.profile,
        page: () => const ProfilePage(),
      ),
      GetPage(
        name: AppRoutes.home,
        page: () => const HomePage(),
      ),
      GetPage(
        name: AppRoutes.itemList,
        page: () => ItemListsPage(
          title: Get.arguments['title'],
          page: Get.arguments['page'],
        ),
      ),
    ];
  }
}
