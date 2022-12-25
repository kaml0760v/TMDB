import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tmdp_getx_mvc/_core/app_theme/app_theme.dart';
import 'package:tmdp_getx_mvc/_core/assets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: 100.w,
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     fit: BoxFit.cover,
        //     opacity: 0.2,
        //     image: AssetImage(
        //       Assets.loginBg,
        //     ),
        //   ),
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Center(
                child: Image.asset(
              Assets.tmdbLogo,
            )),
            const Spacer(),
            Container(
              margin: EdgeInsets.only(bottom: 5.h, left: 16, right: 16),
              padding: const EdgeInsets.only(
                bottom: 16,
                top: 16,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Apptheme.grey1),
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Get Started",
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Apptheme.grey1,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const Icon(
                    Icons.arrow_circle_right_outlined,
                    color: Apptheme.grey1,
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
