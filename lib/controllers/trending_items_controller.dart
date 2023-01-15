import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:tmdp_getx_mvc/_core/injection.dart';
import 'package:tmdp_getx_mvc/_core/string_constant.dart';
import 'package:tmdp_getx_mvc/controllers/utility_controller.dart';
import 'package:tmdp_getx_mvc/models/movies.dart';

import '../services/_core/failure.dart';
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

    //movie
    getUpcomingTopRatedMoviesOrTv(page: PageType.popularMovie);
    getUpcomingTopRatedMoviesOrTv(page: PageType.upcomingMovie);
    getUpcomingTopRatedMoviesOrTv(page: PageType.topRatedMovie);
    getUpcomingTopRatedMoviesOrTv(page: PageType.nowPlayingMovie);

    //tv
    getUpcomingTopRatedMoviesOrTv(page: PageType.popularTv, type: StringConstant.tv);
    getUpcomingTopRatedMoviesOrTv(page: PageType.upcomingTv, type: StringConstant.tv);
    getUpcomingTopRatedMoviesOrTv(page: PageType.topRatedTv, type: StringConstant.tv);
    getUpcomingTopRatedMoviesOrTv(page: PageType.nowPlayingTv, type: StringConstant.tv);
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

  /// used to get trending movies and tv shows
  void getTrendingItems({
    required String timeWindow,
    required PageType page,
    String? pageNumber,
  }) async {
    await handleLoader(page);

    final result = await _trendingService.getTrendingItems(
      mediaType: getMediaType(page),
      timeWindow: timeWindow,
      page: pageNumber ?? getPage(page).toString(),
    );

    await handleLoader(page);

    result.fold(
      (l) {
        final message = l.maybeMap(
          orElse: () => StringConstant.someWentWrong,
          unexpected: (value) => value.errorMsg,
        );

        _utilityController.loadSnackbar(title: StringConstant.error, message: message);
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

  /// common function to pass page number to APIs
  int getPage(PageType page) {
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

  /// common function to handle loader
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

  /// common fucntion for handling the apis result.
  Future<void> handleResult(PageType page, dynamic values) async {
    switch (page) {
      case PageType.movie:
        trendingMoviesList.value = List.from(values.map((e) => Items.fromJson(e)));

        break;
      case PageType.tv:
        trendingTvList.value = List.from(values.map((e) => Items.fromJson(e)));
        break;
      case PageType.nowPlayingMovie:
        nowPlayingMovieList.value = List.from(values.map((e) => Items.fromJson(e)));
        break;
      case PageType.nowPlayingTv:
        airingTodayList.value = List.from(values.map((e) => Items.fromJson(e)));
        break;
      case PageType.popularMovie:
        popularMoviesList.value = List.from(values.map((e) => Items.fromJson(e)));
        break;
      case PageType.popularTv:
        popularTvList.value = List.from(values.map((e) => Items.fromJson(e)));
        break;
      case PageType.topRatedMovie:
        topRatedMovieList.value = List.from(values.map((e) => Items.fromJson(e)));
        break;
      case PageType.topRatedTv:
        topRatedTvList.value = List.from(values.map((e) => Items.fromJson(e)));
        break;
      case PageType.upcomingMovie:
        upcomingMovieList.value = List.from(values.map((e) => Items.fromJson(e)));
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

  /// common function to fetch toprated/upcoming/nowplating/popular movies and tv
  void getUpcomingTopRatedMoviesOrTv({
    required PageType page,
    String type = StringConstant.movie,
  }) async {
    await handleLoader(page);

    final result = await _trendingService.getUpcomingTopRatedMoviesOrTv(
      movieType: getMovieOrTvType(page),
      page: getPage(page).toString(),
      type: type,
    );

    await handleLoader(page);

    result.fold(
      (l) {
        final message = l.maybeMap(
          orElse: () => StringConstant.someWentWrong,
          unexpected: (value) => value.errorMsg,
        );

        _utilityController.loadSnackbar(title: StringConstant.error, message: message);
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
        mediaType = StringConstant.nowPlaying;
        break;
      case PageType.nowPlayingTv:
        mediaType = StringConstant.nowPlayingTv;
        break;
      case PageType.popularMovie:
      case PageType.popularTv:
        mediaType = StringConstant.popular.toLowerCase();
        break;
      case PageType.topRatedMovie:
      case PageType.topRatedTv:
        mediaType = StringConstant.topRated;
        break;
      case PageType.upcomingMovie:
        mediaType = StringConstant.upcoming.toLowerCase();
        break;
      case PageType.upcomingTv:
        mediaType = StringConstant.upcomingTv;
        break;
      default:
        break;
    }
    return mediaType;
  }

  void loadMoreItems({
    required PageType page,
    String mediaType = StringConstant.movie,
    String timeWindow = StringConstant.day,
  }) async {
    handleLoader(page);
    handlePageIncrement(page);

    late Either<Failure, Map<dynamic, dynamic>> result;
    if (page == PageType.movie || page == PageType.tv) {
      result = await _trendingService.getTrendingItems(
        mediaType: mediaType.toLowerCase(),
        timeWindow: timeWindow,
        page: getPage(page).toString(),
      );
    } else {
      result = await _trendingService.getUpcomingTopRatedMoviesOrTv(
        movieType: getMovieOrTvType(page),
        type: mediaType.toLowerCase(),
        page: getPage(page).toString(),
      );
    }

    handleLoader(page);

    result.fold(
      (l) {
        final message = l.maybeMap(
          orElse: () => StringConstant.someWentWrong,
          unexpected: (value) => value.errorMsg,
        );

        _utilityController.loadSnackbar(title: StringConstant.error, message: message);
      },
      (r) async {
        final values = r["results"];
        final List<Items> trendingList = List.from(values.map((e) => Items.fromJson(e)));

        handleAddmoreResult(page, trendingList);
      },
    );

    update(['trending_items']);
  }

  void handleAddmoreResult(PageType page, List<Items> list) {
    switch (page) {
      case PageType.movie:
        trendingMoviesList.addAll(list);
        break;
      case PageType.tv:
        trendingTvList.addAll(list);
        break;
      case PageType.upcomingMovie:
        upcomingMovieList.addAll(list);
        break;
      case PageType.upcomingTv:
        onAirTvList.addAll(list);
        break;
      case PageType.popularMovie:
        popularMoviesList.addAll(list);
        break;
      case PageType.popularTv:
        popularTvList.addAll(list);
        break;
      case PageType.topRatedMovie:
        topRatedMovieList.addAll(list);
        break;
      case PageType.topRatedTv:
        topRatedTvList.addAll(list);
        break;
      case PageType.nowPlayingMovie:
        nowPlayingMovieList.addAll(list);
        break;
      case PageType.nowPlayingTv:
        airingTodayList.addAll(list);
        break;
    }
  }

  void handlePageIncrement(PageType page) {
    switch (page) {
      case PageType.movie:
        moviePage += 1;
        break;
      case PageType.tv:
        tvPage += 1;
        break;
      case PageType.upcomingMovie:
        upcomingMoviePage += 1;
        break;
      case PageType.upcomingTv:
        onAirTvPage += 1;
        break;
      case PageType.popularMovie:
        popularMoviePage += 1;
        break;
      case PageType.popularTv:
        popularTvPage += 1;
        break;
      case PageType.topRatedMovie:
        topRatedMoviePage += 1;
        break;
      case PageType.topRatedTv:
        topRatedTvPage += 1;
        break;
      case PageType.nowPlayingMovie:
        nowPlayingMoviePage += 1;
        break;
      case PageType.nowPlayingTv:
        airingTodayPage += 1;
        break;
    }
    return;
  }
}
