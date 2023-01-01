import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdp_getx_mvc/_core/app_theme/app_theme.dart';
import 'package:tmdp_getx_mvc/_core/injection.dart';
import 'package:tmdp_getx_mvc/_core/routes/app_routes.dart';
import 'package:tmdp_getx_mvc/_core/utils/auth.dart';
import 'package:tmdp_getx_mvc/view/_core/widgets/loader_dialog.dart';

import '../services/auth_services.dart';

class AuthController extends GetxController {
  final _authService = getIt<AuthServices>();
  final usernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return "Please enter Username!";
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return "Please enter Password!";
    }
    return null;
  }

  Future<void> createGuestSession() async {
    Get.dialog(const AnimatedLoader(), barrierDismissible: false);
    final result = await _authService.createGuestSession();
    Navigator.of(Get.overlayContext!).pop();

    result.fold(
      (l) {
        final message = l.maybeMap(
          orElse: () => "Opps, Something went Wrong!",
          unexpected: (value) => value.errorMsg,
        );

        Get.snackbar(
          'Authentication Failed',
          message,
          backgroundColor: AppTheme.primaryColor,
          dismissDirection: DismissDirection.horizontal,
          barBlur: 0,
          colorText: Colors.white,
        );
      },
      (r) {
        Auth.setGusestSessionId(r['guest_session_id']);
        Get.offAllNamed(AppRoutes.dashBoard);
      },
    );
  }

  void loginWithUsernamePassword() async {}
}
