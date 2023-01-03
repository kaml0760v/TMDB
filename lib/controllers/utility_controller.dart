import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../_core/app_theme/app_theme.dart';

class UtitlityController extends GetxController {
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
}
