import 'package:child_museum/domain/entity/follow/follow.dart';
import 'package:child_museum/domain/repository/follow.dart';
import 'package:child_museum/feature/infrastructure/firebase/firestore.dart';
import 'package:child_museum/feature/infrastructure/mapper/follow_mapper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IFollowRepository implements FollowRepository {
  IFollowRepository();

  final _followDB = Firestore.follow;

  @override
  Future<Follow> follow(
      {required String userId, required String followedUid}) async {
    final docId = _followDB.doc().id;
    final follow = Follow(
      followId: docId,
      followerUid: userId,
      followedUid: followedUid,
      createdAt: DateTime.now(),
    );
    await _followDB.doc(docId).set(FollowMapper.toJSON(follow));
    return follow;
  }

  @override
  Future<void> unFollow({required String followId}) async {
    await _followDB.doc(followId).delete();
  }

  @override
  Future<List<Follow>> getFollowersByUserId(String userId) async {
    return await _followDB
        .where('followedUid', isEqualTo: userId)
        .get()
        .then((value) {
      return value.docs.map((e) {
        return FollowMapper.fromJSON(e.data());
      }).toList();
    });
  }

  @override
  Future<List<Follow>> getFollowedsByUserId(String userId) async {
    return await _followDB
        .where('followerUid', isEqualTo: userId)
        .get()
        .then((value) {
      return value.docs.map((e) {
        return FollowMapper.fromJSON(e.data());
      }).toList();
    });
  }

  @override
  Future<List<Follow>> getFollowInfoByUidAndFollowUid(
      {required String userId, required List<String> followUid}) async {
    if (followUid.isEmpty) return [];
    return await _followDB
        .where('followedUid', isEqualTo: followUid)
        .where('followerUid', isEqualTo: userId)
        .get()
        .then((value) {
      return value.docs.map((e) => FollowMapper.fromJSON(e.data())).toList();
    });
  }
}

final followRepositoryProvider = Provider<FollowRepository>(
  (ref) {
    return IFollowRepository();
  },
);
