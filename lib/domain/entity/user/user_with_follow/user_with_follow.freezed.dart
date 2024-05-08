// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_with_follow.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserWithFollow {
  User get user => throw _privateConstructorUsedError;
  Follow get follow => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserWithFollowCopyWith<UserWithFollow> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserWithFollowCopyWith<$Res> {
  factory $UserWithFollowCopyWith(
          UserWithFollow value, $Res Function(UserWithFollow) then) =
      _$UserWithFollowCopyWithImpl<$Res, UserWithFollow>;
  @useResult
  $Res call({User user, Follow follow});

  $UserCopyWith<$Res> get user;
  $FollowCopyWith<$Res> get follow;
}

/// @nodoc
class _$UserWithFollowCopyWithImpl<$Res, $Val extends UserWithFollow>
    implements $UserWithFollowCopyWith<$Res> {
  _$UserWithFollowCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? follow = null,
  }) {
    return _then(_value.copyWith(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      follow: null == follow
          ? _value.follow
          : follow // ignore: cast_nullable_to_non_nullable
              as Follow,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $FollowCopyWith<$Res> get follow {
    return $FollowCopyWith<$Res>(_value.follow, (value) {
      return _then(_value.copyWith(follow: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserWithFollowImplCopyWith<$Res>
    implements $UserWithFollowCopyWith<$Res> {
  factory _$$UserWithFollowImplCopyWith(_$UserWithFollowImpl value,
          $Res Function(_$UserWithFollowImpl) then) =
      __$$UserWithFollowImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({User user, Follow follow});

  @override
  $UserCopyWith<$Res> get user;
  @override
  $FollowCopyWith<$Res> get follow;
}

/// @nodoc
class __$$UserWithFollowImplCopyWithImpl<$Res>
    extends _$UserWithFollowCopyWithImpl<$Res, _$UserWithFollowImpl>
    implements _$$UserWithFollowImplCopyWith<$Res> {
  __$$UserWithFollowImplCopyWithImpl(
      _$UserWithFollowImpl _value, $Res Function(_$UserWithFollowImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? follow = null,
  }) {
    return _then(_$UserWithFollowImpl(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      follow: null == follow
          ? _value.follow
          : follow // ignore: cast_nullable_to_non_nullable
              as Follow,
    ));
  }
}

/// @nodoc

class _$UserWithFollowImpl implements _UserWithFollow {
  const _$UserWithFollowImpl({required this.user, required this.follow});

  @override
  final User user;
  @override
  final Follow follow;

  @override
  String toString() {
    return 'UserWithFollow(user: $user, follow: $follow)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserWithFollowImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.follow, follow) || other.follow == follow));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user, follow);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserWithFollowImplCopyWith<_$UserWithFollowImpl> get copyWith =>
      __$$UserWithFollowImplCopyWithImpl<_$UserWithFollowImpl>(
          this, _$identity);
}

abstract class _UserWithFollow implements UserWithFollow {
  const factory _UserWithFollow(
      {required final User user,
      required final Follow follow}) = _$UserWithFollowImpl;

  @override
  User get user;
  @override
  Follow get follow;
  @override
  @JsonKey(ignore: true)
  _$$UserWithFollowImplCopyWith<_$UserWithFollowImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
