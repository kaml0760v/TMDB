import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdp_getx_mvc/controllers/auth_controller.dart';
import 'package:tmdp_getx_mvc/controllers/configration_controller.dart';
import 'package:tmdp_getx_mvc/view/_core/buttons.dart';
import 'package:tmdp_getx_mvc/view/_core/presentation_method.dart';

import 'widgets/custom_app_bar.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authContoller = Get.find<AuthController>();
    final configController = Get.find<ConfigurationController>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomAppBar(),
            const Spacer(),
            
            PrimaryButton(btnText: "Logout", onPressed: authContoller.logout),
          ],
        ),
      ),
    );
  }
}
