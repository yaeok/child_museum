// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_user_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SearchUserState {
  List<User> get resultUsers => throw _privateConstructorUsedError;
  List<String> get follows => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SearchUserStateCopyWith<SearchUserState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchUserStateCopyWith<$Res> {
  factory $SearchUserStateCopyWith(
          SearchUserState value, $Res Function(SearchUserState) then) =
      _$SearchUserStateCopyWithImpl<$Res, SearchUserState>;
  @useResult
  $Res call({List<User> resultUsers, List<String> follows});
}

/// @nodoc
class _$SearchUserStateCopyWithImpl<$Res, $Val extends SearchUserState>
    implements $SearchUserStateCopyWith<$Res> {
  _$SearchUserStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resultUsers = null,
    Object? follows = null,
  }) {
    return _then(_value.copyWith(
      resultUsers: null == resultUsers
          ? _value.resultUsers
          : resultUsers // ignore: cast_nullable_to_non_nullable
              as List<User>,
      follows: null == follows
          ? _value.follows
          : follows // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchUserStateImplCopyWith<$Res>
    implements $SearchUserStateCopyWith<$Res> {
  factory _$$SearchUserStateImplCopyWith(_$SearchUserStateImpl value,
          $Res Function(_$SearchUserStateImpl) then) =
      __$$SearchUserStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<User> resultUsers, List<String> follows});
}

/// @nodoc
class __$$SearchUserStateImplCopyWithImpl<$Res>
    extends _$SearchUserStateCopyWithImpl<$Res, _$SearchUserStateImpl>
    implements _$$SearchUserStateImplCopyWith<$Res> {
  __$$SearchUserStateImplCopyWithImpl(
      _$SearchUserStateImpl _value, $Res Function(_$SearchUserStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resultUsers = null,
    Object? follows = null,
  }) {
    return _then(_$SearchUserStateImpl(
      resultUsers: null == resultUsers
          ? _value._resultUsers
          : resultUsers // ignore: cast_nullable_to_non_nullable
              as List<User>,
      follows: null == follows
          ? _value._follows
          : follows // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$SearchUserStateImpl implements _SearchUserState {
  const _$SearchUserStateImpl(
      {final List<User> resultUsers = const [],
      final List<String> follows = const []})
      : _resultUsers = resultUsers,
        _follows = follows;

  final List<User> _resultUsers;
  @override
  @JsonKey()
  List<User> get resultUsers {
    if (_resultUsers is EqualUnmodifiableListView) return _resultUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_resultUsers);
  }

  final List<String> _follows;
  @override
  @JsonKey()
  List<String> get follows {
    if (_follows is EqualUnmodifiableListView) return _follows;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_follows);
  }

  @override
  String toString() {
    return 'SearchUserState(resultUsers: $resultUsers, follows: $follows)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchUserStateImpl &&
            const DeepCollectionEquality()
                .equals(other._resultUsers, _resultUsers) &&
            const DeepCollectionEquality().equals(other._follows, _follows));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_resultUsers),
      const DeepCollectionEquality().hash(_follows));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchUserStateImplCopyWith<_$SearchUserStateImpl> get copyWith =>
      __$$SearchUserStateImplCopyWithImpl<_$SearchUserStateImpl>(
          this, _$identity);
}

abstract class _SearchUserState implements SearchUserState {
  const factory _SearchUserState(
      {final List<User> resultUsers,
      final List<String> follows}) = _$SearchUserStateImpl;

  @override
  List<User> get resultUsers;
  @override
  List<String> get follows;
  @override
  @JsonKey(ignore: true)
  _$$SearchUserStateImplCopyWith<_$SearchUserStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
