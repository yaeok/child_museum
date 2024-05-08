import 'package:child_museum/domain/entity/follow/follow.dart';

abstract class FollowRepository {
  Future<Follow> follow({required String userId, required String followedUid});
  Future<void> unFollow({required String followId});
  // 自分をフォローしているユーザーのIDを取得（フォロワー）
  Future<List<Follow>> getFollowersByUserId(String userId);
  // 自分がフォローしているユーザーのIDを取得（フォロー）
  Future<List<Follow>> getFollowedsByUserId(String userId);
  // 自分と相手の情報を使用してフォローしているかチェック
  Future<List<Follow>> getFollowInfoByUidAndFollowUid(
      {required String userId, required List<String> followUid});
}
