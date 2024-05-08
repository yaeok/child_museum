import 'package:freezed_annotation/freezed_annotation.dart';

part 'follow.freezed.dart';

@freezed
class Follow with _$Follow {
  const factory Follow({
    String? followId,
    // フォローされた人のUID
    required String followedUid,
    // フォローした人のUID
    required String followerUid,
    required DateTime createdAt,
  }) = _Follow;
}
