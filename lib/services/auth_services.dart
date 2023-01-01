import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tmdp_getx_mvc/services/_core/failure.dart';
import 'package:tmdp_getx_mvc/services/_core/infra_methods.dart';

@LazySingleton()
class AuthServices {
  Future<Either<Failure, Map>> createGuestSession() async {
    return await NetworkCall<Map>().handleApi(
      endpoint: "authentication/guest_session/new",
      handleSuccess: (responseBody) async {
        return right(responseBody);
      },
    );
  }
}
