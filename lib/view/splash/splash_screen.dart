import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tmdp_getx_mvc/_core/app_theme/app_theme.dart';
import 'package:tmdp_getx_mvc/_core/assets.dart';
import 'package:tmdp_getx_mvc/_core/routes/app_routes.dart';
import 'package:tmdp_getx_mvc/_core/utils/auth.dart';
import 'package:tmdp_getx_mvc/controllers/auth_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (timer) {
      Auth.isLoggedIn || Auth.isGuestLoggedIn
          ? Get.offNamed(AppRoutes.home)
          : Get.offNamed(AppRoutes.auth);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: 100.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Center(
                child: Image.asset(
              Assets.tmdbLogo,
            )),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Get.offNamed(AppRoutes.auth);
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 5.h, left: 16, right: 16),
                padding: const EdgeInsets.only(
                  bottom: 16,
                  top: 16,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.grey1),
                  borderRadius: BorderRadius.circular(25),
                  color: AppTheme.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (Auth.isGuestLoggedIn || Auth.isLoggedIn)
                      const CircularProgressIndicator()
                    else ...[
                      Text(
                        "Get Started",
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: AppTheme.grey1,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const Icon(
                        Icons.arrow_circle_right_outlined,
                        color: AppTheme.grey1,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
