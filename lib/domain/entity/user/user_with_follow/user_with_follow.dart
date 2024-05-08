import 'package:child_museum/domain/entity/follow/follow.dart';
import 'package:child_museum/domain/entity/user/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_with_follow.freezed.dart';

@freezed
class UserWithFollow with _$UserWithFollow {
  const factory UserWithFollow({
    required User user,
    required Follow follow,
  }) = _UserWithFollow;
}
