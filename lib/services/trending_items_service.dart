import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tmdp_getx_mvc/services/_core/failure.dart';
import 'package:tmdp_getx_mvc/services/_core/infra_methods.dart';

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

  Future<Either<Failure, Map>> getUpcomingTopRatedMovies({
    required String movieType,
    String page = "",
  }) async {
    return await NetworkCall<Map>().handleApi(
      endpoint: "movie/$movieType",
      queryParameters: {"page": page},
      handleSuccess: (responseBody) async {
        return right(responseBody);
      },
    );
  }

  Future<Either<Failure, Map>> getUpcomingTopRatedTv({
    required String tvType,
    String page = "",
  }) async {
    return await NetworkCall<Map>().handleApi(
      endpoint: "tv/$tvType",
      queryParameters: {"page": page},
      handleSuccess: (responseBody) async {
        return right(responseBody);
      },
    );
  }
}
