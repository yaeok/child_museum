import 'package:child_museum/domain/entity/article/article.dart';
import 'package:child_museum/domain/entity/user/user.dart';
import 'package:child_museum/domain/entity/user/user_with_follow/user_with_follow.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_state.freezed.dart';

@freezed
class AccountState with _$AccountState {
  const factory AccountState({
    required User user,
    @Default([]) List<Article> articles,
    @Default([]) List<UserWithFollow> followeds,
    @Default([]) List<UserWithFollow> followers,
  }) = _AccountState;
}
