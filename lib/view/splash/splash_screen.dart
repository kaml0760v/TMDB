import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tmdp_getx_mvc/_core/assets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: 100.w,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            opacity: 0.2,
            image: AssetImage(
              Assets.loginBg,
            ),
          ),
        ),
        child: Column(
          children: const [
            
          ],
        ),
      )),
    );
  }
}
