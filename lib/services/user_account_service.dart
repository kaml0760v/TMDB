import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tmdp_getx_mvc/_core/utils/auth.dart';
import 'package:tmdp_getx_mvc/services/_core/failure.dart';
import 'package:tmdp_getx_mvc/services/_core/infra_methods.dart';

@LazySingleton()
class UserAccountService {
  Future<Either<Failure, Map>> getAccountDetails() async {
    return await NetworkCall<Map>().handleApi(
      endpoint: "account",
      queryParameters: {"session_id": Auth.getSessionId},
      handleSuccess: (responseBody) async => right(responseBody),
    );
  }
}
