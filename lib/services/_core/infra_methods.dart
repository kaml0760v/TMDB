import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tmdp_getx_mvc/_core/app_constant.dart';
import 'package:tmdp_getx_mvc/_core/string_constant.dart';
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
    Map<String, String>? queryParameters,
    ApiCallType callType = ApiCallType.get,
    required Future<Either<Failure, T>> Function(Map responseBody)
        handleSuccess,
    Future<Either<Failure, T>> Function(Map responseBody)? handle400,
    Future<Either<Failure, T>> Function(Map responseBody)? handle401,
    Future<Either<Failure, T>> Function(Map responseBody)? handle404,
  }) async {
    headers ??= {
      HttpHeaders.contentTypeHeader: 'application/json;charset=utf-8',
      HttpHeaders.authorizationHeader: "Bearer ${envConfig!.readApiToken}"
    };

    late Response response;

    try {
      final String uri = fullUri ?? "${envConfig!.apiBaseUrl}$endpoint";

      if (body != null) {
        body = jsonEncode(body);
      }

      Map<String, dynamic> queryParameter = {
        "api_key": envConfig!.apiKey,
      };

      queryParameter.addAll(queryParameters ?? {});

      if (callType == ApiCallType.get) {
        response = await Dio().get(
          uri,
          options: Options(
            headers: headers,
            sendTimeout: 50000,
            validateStatus: (_) => true,
          ),
          queryParameters: queryParameter,
        );
      } else if (callType == ApiCallType.post) {
        response = await Dio().post(
          uri,
          options: Options(
            headers: headers,
            sendTimeout: 30000,
            validateStatus: (_) => true,
          ),
          queryParameters: queryParameter,
          data: body,
        );
      } else if (callType == ApiCallType.delete) {
        response = await Dio().delete(
          uri,
          options: Options(
            headers: headers,
            sendTimeout: 30000,
            validateStatus: (_) => true,
          ),
          queryParameters: queryParameter,
          data: body,
        );
      }
      final Map responseBody = response.data as Map;

      if (response.statusCode == 200) {
        final result = await handleSuccess(responseBody);
        return result;
      } else if (response.statusCode == 400) {
        if (handle400 != null) {
          return handle400(responseBody);
        } else {
          return left(Failure.commonFailure());
        }
      } else if (response.statusCode == 401) {
        if (handle401 != null) {
          return handle401(responseBody);
        } else {
          return left(Failure.unexpected(
              errorMsg: responseBody[StringConstant.statusMessage]));
        }
      } else if (response.statusCode == 404) {
        if (handle404 != null) {
          return handle404(responseBody);
        } else {
          return left(Failure.unexpected(
              errorMsg: responseBody[StringConstant.statusMessage]));
        }
      } else {
        return left(Failure.commonFailure());
      }
    } on SocketException {
      return left(const Failure.networkError());
    } on TimeoutException catch (_) {
      return left(const Failure.timeout());
    } catch (e) {
      return left(Failure.unexpected(errorMsg: e.toString()));
    }
  }
}
