import 'package:get/get.dart';
import 'package:tmdp_getx_mvc/_core/injection.dart';
import 'package:tmdp_getx_mvc/_core/string_constant.dart';
import 'package:tmdp_getx_mvc/controllers/utility_controller.dart';
import 'package:tmdp_getx_mvc/models/movies.dart';
import 'package:tmdp_getx_mvc/view/_core/presentation_method.dart';

import '../services/trending_items_service.dart';

class TrendingItemsController extends GetxController {
  final _trendingService = getIt<TrendingItemsService>();
  final _utilityController = Get.find<UtilityController>();

  var trendingMovies = <Movies>[].obs;
  var isMovieFetching = false.obs;

  int moviePage = 1;

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
        "lmrlmrl3 $r".printLog();
        final values = r["results"];
        trendingMovies.value = List.from(values.map((e) => Movies.fromJson(e)));
      },
    );
  }

  void resetMoviePage() {
    moviePage = 1;
  }
}
