import 'package:get/get.dart';
import 'package:tmdp_getx_mvc/_core/injection.dart';
import 'package:tmdp_getx_mvc/_core/string_constant.dart';
import 'package:tmdp_getx_mvc/controllers/utility_controller.dart';
import 'package:tmdp_getx_mvc/models/movies.dart';

import '../services/trending_items_service.dart';

enum PageType {
  movie,
  tv,
  upcomingMovie,
  upcomingTv,
  popularMovie,
  popularTv,
  topRatedMovie,
  topRatedTv,
  nowPlayingMovie,
  nowPlayingTv,
}

class TrendingItemsController extends GetxController {
  final _utilityController = Get.find<UtilityController>();

  @override
  void onInit() {
    if (_utilityController.isMovieToday) {
      getTrendingItems(timeWindow: StringConstant.day, page: PageType.movie);
      getTrendingItems(timeWindow: StringConstant.day, page: PageType.tv);
    } else {
      getTrendingItems(timeWindow: StringConstant.week, page: PageType.movie);
      getTrendingItems(timeWindow: StringConstant.week, page: PageType.tv);
    }
    super.onInit();
  }

  final _trendingService = getIt<TrendingItemsService>();

  var trendingMoviesList = <Items>[].obs;
  var trendingTvList = <Items>[].obs;

  var popularMoviesList = <Items>[].obs;
  var upcomingMovieList = <Items>[].obs;
  var nowPlayingMovieList = <Items>[].obs;
  var topRatedMovieList = <Items>[].obs;

  var popularTvList = <Items>[].obs;
  var airingTodayList = <Items>[].obs;
  var onAirTvList = <Items>[].obs;
  var topRatedTvList = <Items>[].obs;

  var isMovieFetching = false.obs;
  var isTvFetching = false.obs;
  var isFetchingMovieItems = false.obs;
  var isFetchingTvItems = false.obs;

  int moviePage = 1;
  int tvPage = 1;

  int popularMoviePage = 1;
  int upcomingMoviePage = 1;
  int nowPlayingMoviePage = 1;
  int topRatedMoviePage = 1;

  int popularTvPage = 1;
  int airingTodayPage = 1;
  int onAirTvPage = 1;
  int topRatedTvPage = 1;

  void getTrendingItems({
    required String timeWindow,
    required PageType page,
  }) async {
    await handleLoader(page);

    final result = await _trendingService.getTrendingItems(
      mediaType: getMediaType(page),
      timeWindow: timeWindow,
      page: getPage(page).toString(),
    );

    await handleLoader(page);

    result.fold(
      (l) {
        final message = l.maybeMap(
          orElse: () => StringConstant.someWentWrong,
          unexpected: (value) => value.errorMsg,
        );

        _utilityController.loadSnackbar(
            title: StringConstant.error, message: message);
      },
      (r) async {
        final values = r["results"];
        await handleResult(page, values);
      },
    );
  }

  void resetMoviePage() {
    moviePage = 1;
  }

  void resetTvPage() {
    tvPage = 1;
  }

  Future<int> getPage(PageType page) async {
    int tempPage = 1;
    switch (page) {
      case PageType.movie:
        tempPage = moviePage;
        break;
      case PageType.tv:
        tempPage = tvPage;
        break;
      case PageType.upcomingMovie:
        tempPage = upcomingMoviePage;
        break;
      case PageType.upcomingTv:
        tempPage = onAirTvPage;
        break;
      case PageType.popularMovie:
        tempPage = popularMoviePage;
        break;
      case PageType.popularTv:
        tempPage = popularTvPage;
        break;
      case PageType.topRatedMovie:
        tempPage = topRatedMoviePage;
        break;
      case PageType.topRatedTv:
        tempPage = topRatedTvPage;
        break;
      case PageType.nowPlayingMovie:
        tempPage = nowPlayingMoviePage;
        break;
      case PageType.nowPlayingTv:
        tempPage = airingTodayPage;
        break;
    }
    return tempPage;
  }

  Future<void> handleLoader(PageType page) async {
    switch (page) {
      case PageType.movie:
        isMovieFetching.value = !isMovieFetching.value;
        break;
      case PageType.tv:
        isTvFetching.value = !isTvFetching.value;
        break;
      case PageType.nowPlayingMovie:
      case PageType.popularMovie:
      case PageType.topRatedMovie:
      case PageType.upcomingMovie:
        isFetchingMovieItems.value = !isFetchingMovieItems.value;
        break;
      case PageType.nowPlayingTv:
      case PageType.popularTv:
      case PageType.topRatedTv:
      case PageType.upcomingTv:
        isFetchingTvItems.value = !isFetchingTvItems.value;
        break;

      default:
        break;
    }
  }

  Future<void> handleResult(PageType page, dynamic values) async {
    switch (page) {
      case PageType.movie:
        trendingMoviesList.value =
            List.from(values.map((e) => Items.fromJson(e)));
        break;
      case PageType.tv:
        trendingTvList.value = List.from(values.map((e) => Items.fromJson(e)));
        break;
      case PageType.nowPlayingMovie:
        nowPlayingMovieList.value =
            List.from(values.map((e) => Items.fromJson(e)));
        break;
      case PageType.nowPlayingTv:
        airingTodayList.value = List.from(values.map((e) => Items.fromJson(e)));
        break;
      case PageType.popularMovie:
        popularMoviesList.value =
            List.from(values.map((e) => Items.fromJson(e)));
        break;
      case PageType.popularTv:
        popularTvList.value = List.from(values.map((e) => Items.fromJson(e)));
        break;
      case PageType.topRatedMovie:
        topRatedMovieList.value =
            List.from(values.map((e) => Items.fromJson(e)));
        break;
      case PageType.topRatedTv:
        topRatedTvList.value = List.from(values.map((e) => Items.fromJson(e)));
        break;
      case PageType.upcomingMovie:
        upcomingMovieList.value =
            List.from(values.map((e) => Items.fromJson(e)));
        break;
      case PageType.upcomingTv:
        onAirTvList.value = List.from(values.map((e) => Items.fromJson(e)));
        break;

      default:
        break;
    }
  }

  String getMediaType(PageType page) {
    String mediaType = '';
    switch (page) {
      case PageType.movie:
        mediaType = StringConstant.movie;
        break;
      case PageType.tv:
        mediaType = StringConstant.tv;
        break;
      default:
        break;
    }
    return mediaType;
  }

  void getUpcomingTopRatedMovies({
    required String movieType,
    required PageType page,
  }) async {
    await handleLoader(page);

    final result = await _trendingService.getUpcomingTopRatedMovies(
      movieType: getMovieOrTvType(page),
      page: getPage(page).toString(),
    );

    await handleLoader(page);

    result.fold(
      (l) {
        final message = l.maybeMap(
          orElse: () => StringConstant.someWentWrong,
          unexpected: (value) => value.errorMsg,
        );

        _utilityController.loadSnackbar(
            title: StringConstant.error, message: message);
      },
      (r) async {
        final values = r["results"];
        await handleResult(page, values);
      },
    );
  }

  String getMovieOrTvType(PageType page) {
    String mediaType = '';
    switch (page) {
      case PageType.nowPlayingMovie:
      case PageType.nowPlayingTv:
        mediaType = StringConstant.nowPlaying;
        break;
      case PageType.popularMovie:
      case PageType.popularTv:
        mediaType = StringConstant.popular;
        break;
      case PageType.topRatedMovie:
      case PageType.topRatedTv:
        mediaType = StringConstant.topRated;
        break;
      case PageType.upcomingMovie:
      case PageType.upcomingTv:
        mediaType = StringConstant.upcoming;
        break;
      default:
        break;
    }
    return mediaType;
  }
}
