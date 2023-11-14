import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_response_model.freezed.dart';

part 'auth_response_model.g.dart';

@unfreezed
class AuthResponseModel with _$AuthResponseModel {
  factory AuthResponseModel({
    required int statusCode,
    required String message,
    required String accessToken,
    required int loginTime,
    required int expirationDuration,
  }) = _AuthResponseModel;

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
    _$AuthResponseModelFromJson(json);

}
