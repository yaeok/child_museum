import 'package:child_museum/domain/entity/follow/follow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FollowMapper {
  static Follow fromJSON(Map<String, dynamic> json) {
    final createdAt = json['createdAt'] as Timestamp;
    return Follow(
      followId: json['followId'] as String?,
      followedUid: json['followedUid'] as String,
      followerUid: json['followerUid'] as String,
      createdAt: createdAt.toDate(),
    );
  }

  static Map<String, dynamic> toJSON(Follow follow) {
    return {
      'followId': follow.followId,
      'followedUid': follow.followedUid,
      'followerUid': follow.followerUid,
      'createdAt': Timestamp.fromDate(follow.createdAt),
    };
  }
}
