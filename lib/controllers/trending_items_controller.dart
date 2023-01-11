import 'package:get/get.dart';
import 'package:tmdp_getx_mvc/_core/injection.dart';
import 'package:tmdp_getx_mvc/_core/string_constant.dart';
import 'package:tmdp_getx_mvc/controllers/utility_controller.dart';
import 'package:tmdp_getx_mvc/models/movies.dart';

import '../services/trending_items_service.dart';

enum PageType {
  movie,
  tv,
  person,
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

  var trendingMovies = <Items>[].obs;
  var trendingTv = <Items>[].obs;
  var trendingPerson = <Items>[].obs;

  var isMovieFetching = false.obs;
  var isTvFetching = false.obs;
  var isPersonFetching = false.obs;

  int moviePage = 1;
  int tvPage = 1;
  int personPage = 1;

  void getTrendingMovies({required String timeWindow, String? page}) async {
    isMovieFetching.value = !isMovieFetching.value;

    final result = await _trendingService.getTrendingItems(
      mediaType: StringConstant.movie,
      timeWindow: timeWindow,
      page: moviePage.toString(),
    );

    isMovieFetching.value = !isMovieFetching.value;

    result.fold(
      (l) {
        final message = l.maybeMap(
          orElse: () => StringConstant.someWentWrong,
          unexpected: (value) => value.errorMsg,
        );

        _utilityController.loadSnackbar(
            title: StringConstant.error, message: message);
      },
      (r) {
        final values = r["results"];
        trendingMovies.value = List.from(values.map((e) => Items.fromJson(e)));
      },
    );
  }

  void getTrendingItems({
    required String timeWindow,
    required PageType page,
  }) async {
    await handleLoader(page);

    final result = await _trendingService.getTrendingItems(
      mediaType: getMediaType(page),
      timeWindow: timeWindow,
      page: moviePage.toString(),
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

  Future<void> handleLoader(PageType page) async {
    switch (page) {
      case PageType.movie:
        isMovieFetching.value = !isMovieFetching.value;
        break;
      case PageType.tv:
        isTvFetching.value = !isTvFetching.value;
        break;
      case PageType.person:
        isPersonFetching.value = !isPersonFetching.value;
        break;
    }
  }

  Future<void> handleResult(PageType page, dynamic values) async {
    switch (page) {
      case PageType.movie:
        trendingMovies.value = List.from(values.map((e) => Items.fromJson(e)));
        break;
      case PageType.tv:
        trendingTv.value = List.from(values.map((e) => Items.fromJson(e)));
        break;
      case PageType.person:
        trendingPerson.value = List.from(values.map((e) => Items.fromJson(e)));
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
      case PageType.person:
        // TODO: Handle this case.
        break;
    }
    return mediaType;
  }
}
