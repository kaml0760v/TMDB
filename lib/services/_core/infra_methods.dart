import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as dio;
import 'package:tmdp_getx_mvc/_core/app_constant.dart';
import 'package:tmdp_getx_mvc/_core/utils/auth.dart';
import 'package:tmdp_getx_mvc/services/_core/failure.dart';

enum ApiCallType {
  get,
  post,
  pot,
  delete,
}

class NetworkCall<T> {
  Future<Either<Failure, T>> handleApi({
    required String endpoint,
    Object? body,
    String? fullUri,
    Map<String, String>? headers,
    ApiCallType callType = ApiCallType.get,
    required Future<Either<Failure, T>> Function(Map responseBody)
        handleSuccess,
    Future<Either<Failure, T>> Function(Map responseBody)? handle400,
  }) async {
    headers ??= {
      HttpHeaders.contentTypeHeader: 'application/json;charset=utf-8',
      HttpHeaders.authorizationHeader: "Bearer ${envConfig!.readApiToken}"
    };

    late dio.Response response;

    try {
      final String uri = fullUri ?? "${envConfig!.apiBaseUrl}/$endpoint";

      if (body != null) {
        body = jsonEncode(body);
      }

      Map<String, dynamic> queryParameter = {
        "api_key": envConfig!.apiKey,
      };

      if (Auth.isLoggedIn) {
        queryParameter["session_id"] = Auth.sessionId;
      }

      if (Auth.isGuestLoggedIn) {
        queryParameter["guest_session_id"] = Auth.guestSessionId;
      }

      if (callType == ApiCallType.get) {
        response = await dio.Dio().get(
          uri,
          options: dio.Options(headers: headers, sendTimeout: 30000),
          queryParameters: queryParameter,
        );
      } else if (callType == ApiCallType.post) {
        response = await dio.Dio().post(
          uri,
          options: dio.Options(headers: headers, sendTimeout: 30000),
          queryParameters: queryParameter,
          data: body,
        );
      } else if (callType == ApiCallType.delete) {
        response = await dio.Dio().delete(
          uri,
          options: dio.Options(headers: headers, sendTimeout: 30000),
          queryParameters: queryParameter,
          data: body,
        );
      }

      final responseBody = jsonDecode(response.data) as Map;

      if (response.statusCode == 200) {
        final result = await handleSuccess(responseBody);
        return result;
      } else if (response.statusCode == 400) {
        if (handle400 != null) {
          return handle400(responseBody);
        } else {
          return left(Failure.commonFailure());
        }
      } else {
        return left(Failure.commonFailure());
      }
    } on SocketException catch (_) {
      return left(const Failure.networkError());
    } on TimeoutException catch (_) {
      return left(const Failure.timeout());
    } catch (e) {
      return left(Failure.unexpected(errorMsg: e.toString()));
    }
  }
}
