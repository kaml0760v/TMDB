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
}
