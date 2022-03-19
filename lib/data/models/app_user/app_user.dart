// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
class AppUser with _$AppUser {
  const AppUser._();
  const factory AppUser({
    required String id,
    @JsonKey(
      name: 'display_name',
      includeIfNull: false,
    )
        required String displayName,
    required String email,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}
