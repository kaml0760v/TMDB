import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdp_getx_mvc/controllers/auth_controller.dart';
import 'package:tmdp_getx_mvc/controllers/configration_controller.dart';
import 'package:tmdp_getx_mvc/controllers/trending_items_controller.dart';
import 'package:tmdp_getx_mvc/view/_core/buttons.dart';
import 'package:tmdp_getx_mvc/view/dash_board/widgets/trending_movie_switch.dart';

import '../../controllers/utility_controller.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/list_header.dart';
import 'widgets/movie_card.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authContoller = Get.find<AuthController>();
    final configController = Get.find<ConfigurationController>();
    final utilityController = Get.find<UtilityController>();
    final controller = Get.put(TrendingItemsController());

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomAppBar(),
            ListHeader(
              title: "Trending",
              subTitle: "Movies",
              viewMoreTap: () {},
              additionalToggleWidget: Obx(
                () => TrendingMovieSwitchBtnBuilder(
                  trendingController: controller,
                  utilityController: utilityController,
                  isFetching: controller.isMovieFetching.value,
                  isToday: utilityController.isMovieToday,
                ),
              ),
            ),
            Flexible(
              child: Obx(
                () {
                  return ListView.builder(
                    itemCount: controller.trendingMoviesList.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return MovieCard(
                        movies: controller.trendingMoviesList[index],
                        posterUrl: configController.posterUrl,
                      );
                    },
                  );
                },
              ),
            ),
            ListHeader(
              title: "Trending",
              subTitle: "Tv",
              viewMoreTap: () {},
              additionalToggleWidget: Obx(
                () => TrendingMovieSwitchBtnBuilder(
                  page: PageType.tv,
                  isFetching: controller.isTvFetching.value,
                  trendingController: controller,
                  utilityController: utilityController,
                  isToday: utilityController.isTvToday,
                ),
              ),
            ),
            Flexible(
              child: Obx(
                () {
                  return ListView.builder(
                    itemCount: controller.trendingTvList.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return MovieCard(
                        movies: controller.trendingTvList[index],
                        posterUrl: configController.posterUrl,
                      );
                    },
                  );
                },
              ),
            ),
            ListHeader(
              title: "Upcoming",
              subTitle: "Movies",
              viewMoreTap: () {},
            ),
            Flexible(
              child: Obx(
                () {
                  return ListView.builder(
                    itemCount: controller.upcomingMovieList.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return MovieCard(
                        movies: controller.upcomingMovieList[index],
                        posterUrl: configController.posterUrl,
                      );
                    },
                  );
                },
              ),
            ),
            PrimaryButton(btnText: "Logout", onPressed: authContoller.logout),
          ],
        ),
      ),
    );
  }
}
