import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_details.freezed.dart';

part 'error_details.g.dart';

@unfreezed
class ErrorDetails with _$ErrorDetails {
  factory ErrorDetails({
    required int errorCode,
    required String errorMessage,
    required String devErrorMessage,
    required int timestamp,
  }) = _ErrorDetails;

  factory ErrorDetails.fromJson(Map<String, dynamic> json) =>
      _$ErrorDetailsFromJson(json);
}
