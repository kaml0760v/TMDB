import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../_core/app_theme/app_theme.dart';
import '../../../_core/core.dart';
import '../../../controllers/trending_items_controller.dart';
import '../../../models/movies.dart';
import '../widgets/movie_card.dart';

import '../../../controllers/configration_controller.dart';
import '../../../controllers/utility_controller.dart';

class ItemListsPage extends StatefulWidget {
  final PageType page;
  final String title;
  const ItemListsPage({
    Key? key,
    required this.title,
    required this.page,
  }) : super(key: key);

  @override
  State<ItemListsPage> createState() => _ItemListsPageState();
}

class _ItemListsPageState extends State<ItemListsPage> {
  final _configurationController = Get.find<ConfigurationController>();

  final _trendingItemController = Get.find<TrendingItemsController>();

  final _utilityController = Get.find<UtilityController>();
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      switch (widget.page) {
        case PageType.movie:
          _trendingItemController.loadMoreItems(
            page: widget.page,
            timeWindow: _utilityController.isMovieToday ? StringConstant.day : StringConstant.week,
          );
          break;
        case PageType.tv:
          _trendingItemController.loadMoreItems(
            page: widget.page,
            timeWindow: _utilityController.isTvToday ? StringConstant.day : StringConstant.week,
          );
          break;
        case PageType.upcomingMovie:
        case PageType.popularMovie:
        case PageType.nowPlayingMovie:
        case PageType.topRatedMovie:
          _trendingItemController.loadMoreItems(
            page: widget.page,
          );
          break;
        case PageType.upcomingTv:
        case PageType.popularTv:
        case PageType.topRatedTv:
        case PageType.nowPlayingTv:
          _trendingItemController.loadMoreItems(
            page: widget.page,
            mediaType: StringConstant.tv,
          );
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        onWillPop();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: GestureDetector(
            onTap:onWillPop,
            child: const Icon(
              Icons.chevron_left,
              color: AppTheme.white,
            ),
          ),
          title: Text(
            widget.title,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: AppTheme.white,
                ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            controller: scrollController,
            children: [
              GetBuilder(
                id: 'trending_items',
                init: _trendingItemController,
                builder: (controller) {
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: getList(widget.page).length,
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      mainAxisExtent: 240,
                    ),
                    itemBuilder: (context, index) {
                      return MovieCard(
                          movies: getList(widget.page)[index],
                          posterUrl: _configurationController.posterUrl);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Items> getList(PageType page) {
    List<Items> list = [];
    switch (page) {
      case PageType.movie:
        list = _trendingItemController.trendingMoviesList;
        break;
      case PageType.tv:
        list = _trendingItemController.trendingTvList;
        break;
      case PageType.upcomingMovie:
        list = _trendingItemController.upcomingMovieList;
        break;
      case PageType.upcomingTv:
        list = _trendingItemController.onAirTvList;
        break;
      case PageType.popularMovie:
        list = _trendingItemController.popularMoviesList;
        break;
      case PageType.popularTv:
        list = _trendingItemController.popularTvList;
        break;
      case PageType.topRatedMovie:
        list = _trendingItemController.topRatedMovieList;
        break;
      case PageType.topRatedTv:
        list = _trendingItemController.topRatedTvList;
        break;
      case PageType.nowPlayingMovie:
        list = _trendingItemController.nowPlayingMovieList;
        break;
      case PageType.nowPlayingTv:
        list = _trendingItemController.airingTodayList;
        break;
    }
    return list;
  }

  void onWillPop() {
    if (widget.page == PageType.movie) {
      if (_utilityController.isMovieToday) {
        _trendingItemController.getTrendingItems(
          timeWindow: StringConstant.day,
          pageNumber: '1',
          page: PageType.movie,
        );
      } else {
        _trendingItemController.getTrendingItems(
          timeWindow: StringConstant.week,
          pageNumber: '1',
          page: PageType.movie,
        );
      }
    } else if (widget.page == PageType.tv) {
      if (_utilityController.isTvToday) {
        _trendingItemController.getTrendingItems(
          timeWindow: StringConstant.day,
          pageNumber: '1',
          page: PageType.tv,
        );
      } else {
        _trendingItemController.getTrendingItems(
          timeWindow: StringConstant.week,
          pageNumber: '1',
          page: PageType.tv,
        );
      }
    } else {
      _trendingItemController.getUpcomingTopRatedMoviesOrTv(page: widget.page);
    }

    Get.back();
  }
}
