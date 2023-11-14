// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthResponseModelImpl _$$AuthResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AuthResponseModelImpl(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      accessToken: json['accessToken'] as String,
      loginTime: json['loginTime'] as int,
      expirationDuration: json['expirationDuration'] as int,
    );

Map<String, dynamic> _$$AuthResponseModelImplToJson(
        _$AuthResponseModelImpl instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'accessToken': instance.accessToken,
      'loginTime': instance.loginTime,
      'expirationDuration': instance.expirationDuration,
    };
