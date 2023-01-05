import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdp_getx_mvc/_core/injection.dart';
import 'package:tmdp_getx_mvc/_core/routes/app_routes.dart';
import 'package:tmdp_getx_mvc/_core/string_constant.dart';
import 'package:tmdp_getx_mvc/_core/utils/auth.dart';
import 'package:tmdp_getx_mvc/controllers/utility_controller.dart';
import 'package:tmdp_getx_mvc/view/_core/widgets/loader_dialog.dart';

import '../services/auth_services.dart';

class AuthController extends GetxController {
  final _authService = getIt<AuthServices>();
  final _utilityController = Get.find<UtitlityController>();

  final usernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return StringConstant.usernameError;
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return StringConstant.passwordError;
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
          orElse: () => StringConstant.someWentWrong,
          unexpected: (value) => value.errorMsg,
        );

        _utilityController.loadSnackbar(
            title: StringConstant.authFailError, message: message);
      },
      (r) {
        Auth.setGusestSessionId(r[StringConstant.guestSessionId] ?? "");
        Auth.setExpiresAt(r['expires_at'] ?? "");
        Get.offAllNamed(AppRoutes.home);
      },
    );
  }

  Future<void> loginWithUsernamePassword() async {
    Get.dialog(const AnimatedLoader(), barrierDismissible: false);
    final result = await _authService.createRequestToken();
    Navigator.of(Get.overlayContext!).pop();

    result.fold(
      (l) {
        final message = l.maybeMap(
          orElse: () => StringConstant.someWentWrong,
          unexpected: (value) => value.errorMsg,
        );

        _utilityController.loadSnackbar(
            title: StringConstant.authFailError, message: message);
      },
      (r) async {
        await getUserToken(requestToken: r[StringConstant.requestToken]);
      },
    );
  }

  Future<void> getUserToken({required String requestToken}) async {
    Get.dialog(const AnimatedLoader(), barrierDismissible: false);
    final result = await _authService.getUserToken(body: {
      "request_token": requestToken,
      "username": usernameController.text.trim(),
      "password": passwordController.text.trim(),
    });
    Navigator.of(Get.overlayContext!).pop();

    result.fold(
      (l) {
        final message = l.maybeMap(
          orElse: () => StringConstant.someWentWrong,
          unexpected: (value) => value.errorMsg,
        );

        _utilityController.loadSnackbar(
            title: StringConstant.authFailError, message: message);
      },
      (r) async {
        Auth.setExpiresAt(r['expires_at'] ?? "");
        await createUserSession(requestToken: r[StringConstant.requestToken]);
      },
    );
  }

  Future<void> createUserSession({required String requestToken}) async {
    Get.dialog(const AnimatedLoader(), barrierDismissible: false);
    final result = await _authService.createUserSession(body: {
      "request_token": requestToken,
    });
    Navigator.of(Get.overlayContext!).pop();

    result.fold(
      (l) {
        final message = l.maybeMap(
          orElse: () => StringConstant.someWentWrong,
          unexpected: (value) => value.errorMsg,
        );

        _utilityController.loadSnackbar(
            title: StringConstant.authFailError, message: message);
      },
      (r) async {
        Auth.setSessionId(r['session_id'] ?? "");
        Get.offAllNamed(AppRoutes.home);
      },
    );
  }

  Future<void> logout() async {
    Get.dialog(const AnimatedLoader(), barrierDismissible: false);
    final result = await _authService.deleteSession();
    Navigator.of(Get.overlayContext!).pop();

    result.fold(
      (l) {
        final message = l.maybeMap(
          orElse: () => StringConstant.someWentWrong,
          unexpected: (value) => value.errorMsg,
        );

        _utilityController.loadSnackbar(
            title: StringConstant.authFailError, message: message);
      },
      (r) {},
    );
    Auth.logOut();
    Get.offAllNamed(AppRoutes.auth);
  }
}
