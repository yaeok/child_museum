import 'package:child_museum/domain/entity/follow/follow.dart';
import 'package:child_museum/domain/entity/user/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_user_state.freezed.dart';

@freezed
class SearchUserState with _$SearchUserState {
  const factory SearchUserState({
    @Default([]) List<User> resultUsers,
    @Default([]) List<String> follows,
  }) = _SearchUserState;
}
