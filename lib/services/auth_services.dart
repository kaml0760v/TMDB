import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tmdp_getx_mvc/_core/utils/auth.dart';
import 'package:tmdp_getx_mvc/services/_core/failure.dart';
import 'package:tmdp_getx_mvc/services/_core/infra_methods.dart';

@LazySingleton()
class AuthServices {
  Future<Either<Failure, Map>> createGuestSession() async {
    return await NetworkCall<Map>().handleApi(
      endpoint: "authentication/guest_session/new",
      handleSuccess: (responseBody) async => right(responseBody),
    );
  }

  Future<Either<Failure, Map>> createRequestToken() async {
    return await NetworkCall<Map>().handleApi(
      endpoint: 'authentication/token/new',
      handleSuccess: (responseBody) async => right(responseBody),
    );
  }

  Future<Either<Failure, Map>> createUserSession({required Map body}) async {
    return await NetworkCall<Map>().handleApi(
      endpoint: 'authentication/token/validate_with_login',
      callType: ApiCallType.post,
      body: body,
      handleSuccess: (responseBody) async => right(responseBody),
    );
  }

  Future<Either<Failure, bool>> deleteSession() async {
    return await NetworkCall<bool>().handleApi(
      endpoint: 'authentication/session',
      callType: ApiCallType.delete,
      body: {
        "session_id":
            Auth.isLoggedIn ? Auth.getSessionId : Auth.getGuestSessionId
      },
      handleSuccess: (responseBody) async => right(true),
    );
  }
}
