import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdp_getx_mvc/_core/utils/preference.dart';
import 'package:url_launcher/url_launcher.dart';

import '../_core/app_theme/app_theme.dart';
import '../view/dash_board/dash_board_page.dart';
import '../view/profile/profile_page.dart';
import '../view/watch_list/watch_list_page.dart';

class UtilityController extends GetxController {
  final _pageIndex = 0.obs;
  final pages = [
    const DashBoardPage(),
    const WatchListPage(),
    const ProfilePage(),
  ].obs;

  int get navIndex => _pageIndex.value;
  
  final _isMovieToday = Preferences.movieIsToday.obs;
  final _isTvToday = Preferences.tvIsToday.obs;

  bool get isMovieToday => _isMovieToday.value;
  bool get isTvToday => _isTvToday.value;

  void setNavIndex(int index) {
    _pageIndex.value = index;
  }

  void toggleTrendingMovieSwitch() {
    _isMovieToday.value = !_isMovieToday.value;
    Preferences.setMoveiIstodayState(_isMovieToday.value);
  }

   void toggleTrendingTvSwitch() {
    _isTvToday.value = !_isTvToday.value;
    Preferences.setTvIstodayState(_isTvToday.value);
  }

  Future<void> loadUrl({required String uri}) async {
    final Uri url = Uri.parse(uri);

    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
    return;
  }

  void loadSnackbar({required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: AppTheme.primaryColor,
      dismissDirection: DismissDirection.horizontal,
      barBlur: 0,
      colorText: AppTheme.white,
    );
  }

  void openExitDialog() {
    Get.dialog(
      AlertDialog(
        title: Text(
          'Do you want to Exit?',
          style: Theme.of(Get.context!)
              .textTheme
              .headline3
              ?.copyWith(color: AppTheme.primaryColor),
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24))),
        actions: [
          TextButton(
            style:
                ButtonStyle(backgroundColor: Colors.transparent.wrapMatProp()),
            child: Text(
              "Close",
              style: Theme.of(Get.context!)
                  .textTheme
                  .bodyText2
                  ?.copyWith(color: AppTheme.primaryColor),
            ),
            onPressed: () => Get.back(),
          ),
          TextButton(
            style:
                ButtonStyle(backgroundColor: Colors.transparent.wrapMatProp()),
            child: Text(
              "Exit",
              style: Theme.of(Get.context!)
                  .textTheme
                  .bodyText2
                  ?.copyWith(color: AppTheme.primaryColor),
            ),
            onPressed: () => exit(0),
          ),
        ],
      ),
    );
  }
}
