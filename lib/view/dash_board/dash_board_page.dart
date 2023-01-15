import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdp_getx_mvc/_core/routes/app_routes.dart';
import 'package:tmdp_getx_mvc/_core/string_constant.dart';
import 'package:tmdp_getx_mvc/controllers/auth_controller.dart';
import 'package:tmdp_getx_mvc/controllers/trending_items_controller.dart';
import 'package:tmdp_getx_mvc/view/_core/buttons.dart';
import 'package:tmdp_getx_mvc/view/dash_board/widgets/list_builder.dart';
import 'package:tmdp_getx_mvc/view/dash_board/widgets/trending_movie_switch.dart';

import '../../controllers/utility_controller.dart';
import 'widgets/custom_app_bar.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authContoller = Get.find<AuthController>();
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
                    onAddMoreTap: () {
                      controller.loadMoreItems(
                        page: PageType.movie,
                        mediaType: StringConstant.movie,
                        timeWindow: utilityController.isMovieToday
                            ? StringConstant.day
                            : StringConstant.week,
                      );
                    },
                    viewMoreTap: () {
                      if (utilityController.isMovieToday) {
                        controller.getTrendingItems(
                          timeWindow: StringConstant.day,
                          pageNumber: '1',
                          page: PageType.movie,
                        );
                      } else {
                        controller.getTrendingItems(
                          timeWindow: StringConstant.week,
                          pageNumber: '1',
                          page: PageType.movie,
                        );
                      }

                      Get.toNamed(
                        AppRoutes.itemList,
                        arguments: {
                          "title": "${StringConstant.trending} ${StringConstant.movies}",
                          "page": PageType.movie,
                        },
                      );
                    },
                    additinalWidget: Obx(
                      () => TrendingMovieSwitchBtnBuilder(
                        trendingController: controller,
                        utilityController: utilityController,
                        isFetching: controller.isMovieFetching.value,
                        isToday: utilityController.isMovieToday,
                      ),
                    ),
                  ),
                  ListBuilder(
                    title: StringConstant.trending,
                    subTitle: StringConstant.tvSeries,
                    items: controller.trendingTvList,
                    onAddMoreTap: () {
                      controller.loadMoreItems(
                        page: PageType.tv,
                        mediaType: StringConstant.tv,
                        timeWindow:
                            utilityController.isTvToday ? StringConstant.day : StringConstant.week,
                      );
                    },
                    viewMoreTap: () {
                      if (utilityController.isTvToday) {
                        controller.getTrendingItems(
                          timeWindow: StringConstant.day,
                          pageNumber: '1',
                          page: PageType.tv,
                        );
                      } else {
                        controller.getTrendingItems(
                          timeWindow: StringConstant.week,
                          pageNumber: '1',
                          page: PageType.tv,
                        );
                      }

                      Get.toNamed(
                        AppRoutes.itemList,
                        arguments: {
                          "title": "${StringConstant.trending} ${StringConstant.tvSeries}",
                          "page": PageType.tv,
                        },
                      );
                    },
                    additinalWidget: Obx(
                      () => TrendingMovieSwitchBtnBuilder(
                        trendingController: controller,
                        utilityController: utilityController,
                        isFetching: controller.isTvFetching.value,
                        isToday: utilityController.isTvToday,
                      ),
                    ),
                  ),
                  ListBuilder(
                    title: StringConstant.upcoming,
                    subTitle: StringConstant.movies,
                    items: controller.upcomingMovieList,
                    viewMoreTap: () {
                      Get.toNamed(
                        AppRoutes.itemList,
                        arguments: {
                          "title": "${StringConstant.upcoming} ${StringConstant.movies}",
                          "page": PageType.upcomingMovie,
                        },
                      );
                    },
                    onAddMoreTap: () {
                      controller.loadMoreItems(
                        page: PageType.upcomingMovie,
                      );
                    },
                  ),
                  ListBuilder(
                    title: StringConstant.upcoming,
                    subTitle: StringConstant.tvSeries,
                    viewMoreTap: () {
                      Get.toNamed(
                        AppRoutes.itemList,
                        arguments: {
                          "title": "${StringConstant.upcoming} ${StringConstant.tvSeries}",
                          "page": PageType.upcomingTv,
                        },
                      );
                    },
                    items: controller.onAirTvList,
                    onAddMoreTap: () {
                      controller.loadMoreItems(
                        page: PageType.upcomingTv,
                        mediaType: StringConstant.tv,
                      );
                    },
                  ),
                  ListBuilder(
                    title: StringConstant.popular,
                    subTitle: StringConstant.movies,
                    viewMoreTap: () {
                      Get.toNamed(
                        AppRoutes.itemList,
                        arguments: {
                          "title": "${StringConstant.popular} ${StringConstant.movies}",
                          "page": PageType.popularMovie,
                        },
                      );
                    },
                    onAddMoreTap: () {
                      controller.loadMoreItems(
                        page: PageType.popularMovie,
                      );
                    },
                    items: controller.popularMoviesList,
                  ),
                  ListBuilder(
                    title: StringConstant.popular,
                    subTitle: StringConstant.tvSeries,
                    viewMoreTap: () {
                      Get.toNamed(
                        AppRoutes.itemList,
                        arguments: {
                          "title": "${StringConstant.popular} ${StringConstant.tvSeries}",
                          "page": PageType.popularTv,
                        },
                      );
                    },
                    onAddMoreTap: () {
                      controller.loadMoreItems(
                        page: PageType.popularTv,
                        mediaType: StringConstant.tv,
                      );
                    },
                    items: controller.popularTvList,
                  ),
                  ListBuilder(
                    title: StringConstant.topRatedText,
                    viewMoreTap: () {
                      Get.toNamed(
                        AppRoutes.itemList,
                        arguments: {
                          "title": "${StringConstant.topRatedText} ${StringConstant.movies}",
                          "page": PageType.topRatedMovie,
                        },
                      );
                    },
                    subTitle: StringConstant.movies,
                    onAddMoreTap: () {
                      controller.loadMoreItems(
                        page: PageType.topRatedMovie,
                      );
                    },
                    items: controller.topRatedMovieList,
                  ),
                  ListBuilder(
                    title: StringConstant.topRatedText,
                    viewMoreTap: () {
                      Get.toNamed(
                        AppRoutes.itemList,
                        arguments: {
                          "title": "${StringConstant.topRatedText} ${StringConstant.tvSeries}",
                          "page": PageType.topRatedTv,
                        },
                      );
                    },
                    subTitle: StringConstant.tvSeries,
                    onAddMoreTap: () {
                      controller.loadMoreItems(
                        page: PageType.topRatedTv,
                        mediaType: StringConstant.tv,
                      );
                    },
                    items: controller.topRatedTvList,
                  ),
                  ListBuilder(
                    title: StringConstant.nowPlayingText,
                    viewMoreTap: () {
                      Get.toNamed(
                        AppRoutes.itemList,
                        arguments: {
                          "title": "${StringConstant.nowPlayingText} ${StringConstant.movies}",
                          "page": PageType.nowPlayingMovie,
                        },
                      );
                    },
                    subTitle: StringConstant.movies,
                    onAddMoreTap: () {
                      controller.loadMoreItems(
                        page: PageType.nowPlayingMovie,
                      );
                    },
                    items: controller.nowPlayingMovieList,
                  ),
                  ListBuilder(
                    title: StringConstant.nowPlayingText,
                    viewMoreTap: () {
                      Get.toNamed(
                        AppRoutes.itemList,
                        arguments: {
                          "title": "${StringConstant.nowPlayingText} ${StringConstant.tvSeries}",
                          "page": PageType.nowPlayingTv,
                        },
                      );
                    },
                    subTitle: StringConstant.tvSeries,
                    onAddMoreTap: () {
                      controller.loadMoreItems(
                        page: PageType.nowPlayingTv,
                        mediaType: StringConstant.tv,
                      );
                    },
                    items: controller.airingTodayList,
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
