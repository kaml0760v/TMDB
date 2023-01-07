import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tmdp_getx_mvc/services/_core/failure.dart';
import 'package:tmdp_getx_mvc/services/_core/infra_methods.dart';

@LazySingleton()
class ConfigurationService {
  Future<Either<Failure, Map>> getConfigation() async {
    return await NetworkCall<Map>().handleApi(
      endpoint: "configuration",
      handleSuccess: (responseBody) async {
        return right(responseBody);
      },
    );
  }
}
