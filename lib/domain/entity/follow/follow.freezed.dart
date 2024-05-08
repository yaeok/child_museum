// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'follow.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Follow {
  String? get followId => throw _privateConstructorUsedError;
  String get followedUid => throw _privateConstructorUsedError;
  String get followerUid => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FollowCopyWith<Follow> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FollowCopyWith<$Res> {
  factory $FollowCopyWith(Follow value, $Res Function(Follow) then) =
      _$FollowCopyWithImpl<$Res, Follow>;
  @useResult
  $Res call(
      {String? followId,
      String followedUid,
      String followerUid,
      DateTime createdAt});
}

/// @nodoc
class _$FollowCopyWithImpl<$Res, $Val extends Follow>
    implements $FollowCopyWith<$Res> {
  _$FollowCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? followId = freezed,
    Object? followedUid = null,
    Object? followerUid = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      followId: freezed == followId
          ? _value.followId
          : followId // ignore: cast_nullable_to_non_nullable
              as String?,
      followedUid: null == followedUid
          ? _value.followedUid
          : followedUid // ignore: cast_nullable_to_non_nullable
              as String,
      followerUid: null == followerUid
          ? _value.followerUid
          : followerUid // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FollowImplCopyWith<$Res> implements $FollowCopyWith<$Res> {
  factory _$$FollowImplCopyWith(
          _$FollowImpl value, $Res Function(_$FollowImpl) then) =
      __$$FollowImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? followId,
      String followedUid,
      String followerUid,
      DateTime createdAt});
}

/// @nodoc
class __$$FollowImplCopyWithImpl<$Res>
    extends _$FollowCopyWithImpl<$Res, _$FollowImpl>
    implements _$$FollowImplCopyWith<$Res> {
  __$$FollowImplCopyWithImpl(
      _$FollowImpl _value, $Res Function(_$FollowImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? followId = freezed,
    Object? followedUid = null,
    Object? followerUid = null,
    Object? createdAt = null,
  }) {
    return _then(_$FollowImpl(
      followId: freezed == followId
          ? _value.followId
          : followId // ignore: cast_nullable_to_non_nullable
              as String?,
      followedUid: null == followedUid
          ? _value.followedUid
          : followedUid // ignore: cast_nullable_to_non_nullable
              as String,
      followerUid: null == followerUid
          ? _value.followerUid
          : followerUid // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$FollowImpl implements _Follow {
  const _$FollowImpl(
      {this.followId,
      required this.followedUid,
      required this.followerUid,
      required this.createdAt});

  @override
  final String? followId;
  @override
  final String followedUid;
  @override
  final String followerUid;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'Follow(followId: $followId, followedUid: $followedUid, followerUid: $followerUid, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FollowImpl &&
            (identical(other.followId, followId) ||
                other.followId == followId) &&
            (identical(other.followedUid, followedUid) ||
                other.followedUid == followedUid) &&
            (identical(other.followerUid, followerUid) ||
                other.followerUid == followerUid) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, followId, followedUid, followerUid, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FollowImplCopyWith<_$FollowImpl> get copyWith =>
      __$$FollowImplCopyWithImpl<_$FollowImpl>(this, _$identity);
}

abstract class _Follow implements Follow {
  const factory _Follow(
      {final String? followId,
      required final String followedUid,
      required final String followerUid,
      required final DateTime createdAt}) = _$FollowImpl;

  @override
  String? get followId;
  @override
  String get followedUid;
  @override
  String get followerUid;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$FollowImplCopyWith<_$FollowImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
