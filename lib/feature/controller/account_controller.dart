import 'package:child_museum/domain/entity/user/user.dart' as entity;
import 'package:child_museum/domain/entity/user/user_with_follow/user_with_follow.dart';
import 'package:child_museum/domain/repository/article.dart';
import 'package:child_museum/domain/repository/follow.dart';
import 'package:child_museum/domain/repository/user.dart';
import 'package:child_museum/feature/controller/state/account/account_state.dart';
import 'package:child_museum/feature/infrastructure/article.dart';
import 'package:child_museum/feature/infrastructure/follow.dart';
import 'package:child_museum/feature/infrastructure/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class AccountNotifier extends StateNotifier<AccountState> {
  AccountNotifier({
    required this.userRepository,
    required this.articleRepository,
    required this.followRepository,
  }) : super(
          AccountState(
            user: entity.User(
              uid: '',
              username: '',
              email: '',
              photoUrl: '',
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
            articles: [],
            followeds: [],
            followers: [],
          ),
        );

  final UserRepository userRepository;
  final ArticleRepository articleRepository;
  final FollowRepository followRepository;

  Future<void> initialize() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final user = await userRepository.getUser(uid);
    final articles = await articleRepository.getArticlesByOwnerId(uid);
    // 自分がフォローしているユーザーを取得
    final followeds = await followedsScreenInitialize();
    // 自分のフォロワーを取得
    final followers = await followerScreenInitialize();
    state = state.copyWith(
      user: user,
      articles: articles,
      followeds: followeds,
      followers: followers,
    );
  }

  Future<void> uploadImage(XFile image) async {
    final user = FirebaseAuth.instance.currentUser!;
    final photoUrl = await userRepository.updatePhotoUrl(user.uid, image);
    state = state.copyWith(
      user: state.user.copyWith(photoUrl: photoUrl),
    );
  }

  Future<List<UserWithFollow>> followedsScreenInitialize() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final followeds = await followRepository.getFollowedsByUserId(uid);
    final followedsUid = followeds.map((e) => e.followedUid).toList();
    final users = await userRepository.getUsersByUids(followedsUid);
    return users
        .map(
          (e) => UserWithFollow(
            user: e,
            follow: followeds.firstWhere(
              (element) => element.followedUid == e.uid,
            ),
          ),
        )
        .toList();
  }

  Future<List<UserWithFollow>> followerScreenInitialize() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final followers = await followRepository.getFollowersByUserId(uid);
    final followersUid = followers.map((e) => e.followerUid).toList();
    final users = await userRepository.getUsersByUids(followersUid);
    return users
        .map(
          (e) => UserWithFollow(
            user: e,
            follow: followers.firstWhere(
              (element) => element.followerUid == e.uid,
            ),
          ),
        )
        .toList();
  }

  Future<List<entity.User>> searchUserByEmail(String email) async {
    final userList = await userRepository.searchUserByEmail(email: email);
    return userList;
  }

  Future<void> follow(String followUid) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final result =
        await followRepository.follow(userId: uid, followedUid: followUid);
    state = state.copyWith(
      followeds: [
        ...state.followeds,
        UserWithFollow(
          user: state.user,
          follow: result,
        ),
      ],
    );
  }

  Future<void> unFollow(String followId) async {
    await followRepository.unFollow(followId: followId);
    state = state.copyWith(
      followeds: state.followeds
          .where((element) => element.follow.followId != followId)
          .toList(),
    );
  }
}

final accountControllerProvider =
    StateNotifierProvider.autoDispose<AccountNotifier, AccountState>(
  (ref) {
    return AccountNotifier(
      userRepository: ref.watch(userRepositoryProvider),
      articleRepository: ref.watch(articleRepositoryProvider),
      followRepository: ref.watch(followRepositoryProvider),
    );
  },
);
