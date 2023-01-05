import 'package:get/get.dart';

import '../view/dash_board/dash_board_page.dart';
import '../view/profile/profile_page.dart';
import '../view/watch_list/watch_list_page.dart';

class HomeController extends GetxController {
  final _pageIndex = 0.obs;
  final _pages = [
    const DashBoardPage(),
    const WatchListPage(),
    const ProfilePage(),
  ].obs;

  int get navIndex => _pageIndex.value;

  void setNavIndex(int index) {
    _pageIndex.value = index;
  }
}
