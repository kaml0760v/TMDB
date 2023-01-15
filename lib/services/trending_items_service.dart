import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tmdp_getx_mvc/services/_core/failure.dart';
import 'package:tmdp_getx_mvc/services/_core/infra_methods.dart';
import 'package:tmdp_getx_mvc/view/_core/presentation_method.dart';

@LazySingleton()
class TrendingItemsService {
  Future<Either<Failure, Map>> getTrendingItems({
    required String mediaType,
    required String timeWindow,
    String page = "",
  }) async {
    return await NetworkCall<Map>().handleApi(
      endpoint: "trending/$mediaType/$timeWindow",
      queryParameters: {"page": page},
      handleSuccess: (responseBody) async {
        return right(responseBody);
      },
    );
  }

  Future<Either<Failure, Map>> getUpcomingTopRatedMoviesOrTv({
    required String movieType,
    required String type,
    String page = "",
  }) async {
    "wmwfmwlfm $type  $movieType".printLog();
    "wmwfmwlfm $page".printLog();
    return await NetworkCall<Map>().handleApi(
      endpoint: "$type/$movieType",
      queryParameters: {"page": page},
      handleSuccess: (responseBody) async {
        return right(responseBody);
      },
    );
  }
}
