import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';

part 'app_user.g.dart';

@unfreezed
class AppUser with _$AppUser {
  factory AppUser({
    int? id,
    required String userName,
    required String password,
    @Default("Admin") String role,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
}
