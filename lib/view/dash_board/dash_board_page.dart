import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdp_getx_mvc/controllers/auth_controller.dart';
import 'package:tmdp_getx_mvc/controllers/configration_controller.dart';
import 'package:tmdp_getx_mvc/controllers/trending_items_controller.dart';
import 'package:tmdp_getx_mvc/controllers/utility_controller.dart';
import 'package:tmdp_getx_mvc/view/_core/buttons.dart';
import 'package:tmdp_getx_mvc/view/_core/presentation_method.dart';
import 'package:tmdp_getx_mvc/view/dash_board/widgets/trending_movie_switch.dart';

import 'widgets/custom_app_bar.dart';
import 'widgets/list_header.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authContoller = Get.find<AuthController>();
    final configController = Get.find<ConfigurationController>();
    final _controller = Get.put(TrendingItemsController());

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomAppBar(),
            const Spacer(),
            ListHeader(
              title: "Trending",
              subTitle: "Movies",
              viewMoreTap: (){},
              additionalToggleWidget: TrendingMovieSwitchBtnBuilder()  ,
            ),

            PrimaryButton(btnText: "Logout", onPressed: authContoller.logout),
          ],
        ),
      ),
    );
  }
}
