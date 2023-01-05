import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tmdp_getx_mvc/_core/utils/auth.dart';
import 'package:tmdp_getx_mvc/controllers/auth_controller.dart';
import 'package:tmdp_getx_mvc/view/_core/buttons.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
   
    final authContoller = Get.find<AuthController>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              child: Text(" DateTime.parse(Auth.getsessionExpireAt ?? "
                  ",).toString()"),
            ),
            PrimaryButton(btnText: "Logout", onPressed: authContoller.logout),
          ],
        ),
      ),
    );
  }
}
