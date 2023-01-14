import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdp_getx_mvc/_core/string_constant.dart';
import 'package:tmdp_getx_mvc/controllers/auth_controller.dart';
import 'package:tmdp_getx_mvc/controllers/configration_controller.dart';
import 'package:tmdp_getx_mvc/controllers/trending_items_controller.dart';
import 'package:tmdp_getx_mvc/view/_core/buttons.dart';
import 'package:tmdp_getx_mvc/view/_core/presentation_method.dart';
import 'package:tmdp_getx_mvc/view/dash_board/widgets/list_builder.dart';
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
          children: [
            const CustomAppBar(),
            Expanded(
              child: ListView(
                children: [
                  ListBuilder(
                    title: StringConstant.trending,
                    subTitle: StringConstant.movies,
                    items: controller.trendingMoviesList,
                    additinalWidget: Obx(
                      () => TrendingMovieSwitchBtnBuilder(
                        trendingController: controller,
                        utilityController: utilityController,
                        isFetching: controller.isMovieFetching.value,
                        isToday: utilityController.isMovieToday,
                      ),
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
                  SizedBox(
                    height: 200,
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
                  SizedBox(
                    height: 200,
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
                  ListHeader(
                    title: "Upcoming",
                    subTitle: "Tv",
                    viewMoreTap: () {
                      "ef,lflef ${controller.popularMoviesList[0].id}".printLog();
                    },
                  ),
                  SizedBox(
                    height: 200,
                    child: Obx(
                      () {
                        return ListView.builder(
                          itemCount: controller.onAirTvList.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return MovieCard(
                              movies: controller.onAirTvList[index],
                              posterUrl: configController.posterUrl,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  ListHeader(
                    title: "Popular",
                    subTitle: "Movies",
                    viewMoreTap: () {
                      "ef,lflef ${controller.popularMoviesList[0].id}".printLog();
                    },
                  ),
                  SizedBox(
                    height: 200,
                    child: Obx(
                      () {
                        return ListView.builder(
                          itemCount: controller.popularMoviesList.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return MovieCard(
                              movies: controller.popularMoviesList[index],
                              posterUrl: configController.posterUrl,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  ListHeader(
                    title: "Popular",
                    subTitle: "Tv",
                    viewMoreTap: () {},
                  ),
                  SizedBox(
                    height: 200,
                    child: Obx(
                      () {
                        return ListView.builder(
                          itemCount: controller.popularTvList.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return MovieCard(
                              movies: controller.popularTvList[index],
                              posterUrl: configController.posterUrl,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  ListHeader(
                    title: "Top-rated",
                    subTitle: "Movies",
                    viewMoreTap: () {
                      "ef,lflef ${controller.popularMoviesList[0].id}".printLog();
                    },
                  ),
                  SizedBox(
                    height: 200,
                    child: Obx(
                      () {
                        return ListView.builder(
                          itemCount: controller.topRatedMovieList.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return MovieCard(
                              movies: controller.topRatedTvList[index],
                              posterUrl: configController.posterUrl,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  ListHeader(
                    title: "Top-rated",
                    subTitle: "Tv",
                    viewMoreTap: () {
                      "ef,lflef ${controller.popularMoviesList[0].id}".printLog();
                    },
                  ),
                  SizedBox(
                    height: 200,
                    child: Obx(
                      () {
                        return ListView.builder(
                          itemCount: controller.topRatedTvList.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return MovieCard(
                              movies: controller.topRatedTvList[index],
                              posterUrl: configController.posterUrl,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  ListHeader(
                    title: "Now Playing",
                    subTitle: "Movies",
                    viewMoreTap: () {
                      "ef,lflef ${controller.popularMoviesList[0].id}".printLog();
                    },
                  ),
                  SizedBox(
                    height: 200,
                    child: Obx(
                      () {
                        return ListView.builder(
                          itemCount: controller.nowPlayingMovieList.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return MovieCard(
                              movies: controller.nowPlayingMovieList[index],
                              posterUrl: configController.posterUrl,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  ListHeader(
                    title: "Now Playing",
                    subTitle: "Tv",
                    viewMoreTap: () {},
                  ),
                  SizedBox(
                    height: 200,
                    child: Obx(
                      () {
                        return ListView.builder(
                          itemCount: controller.airingTodayList.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return MovieCard(
                              movies: controller.airingTodayList[index],
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
          ],
        ),
      ),
    );
  }
}
