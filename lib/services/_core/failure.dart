
import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.timeout() = _TimeOut;
  const factory Failure.networkError() = _NetworkError;
  const factory Failure.serverError() = _ServerError;
  const factory Failure.unexpected({required String errorMsg}) = _Unexpected;
  factory Failure.commonFailure() => const Failure.unexpected(
        errorMsg: "Some error occurred. Please try again",
      );
}
