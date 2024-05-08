import 'package:child_museum/domain/entity/user/user_with_follow/user_with_follow.dart';
import 'package:child_museum/feature/controller/account_controller.dart';
import 'package:child_museum/presentation/pages/account/enum/screen_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FollowListView extends HookConsumerWidget {
  const FollowListView({
    Key? key,
    required this.screenType,
  }) : super(key: key);

  final ScreenType screenType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(accountControllerProvider);
    final isLoading = useState<bool>(true);

    useEffect(() {
      Future<void> init() async {
        await ref.read(accountControllerProvider.notifier).initialize();
        isLoading.value = false;
      }

      init();
      return null;
    }, const []);

    if (isLoading.value) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${screenType == ScreenType.follow ? screenTypeMap[ScreenType.follow]! : screenTypeMap[ScreenType.follower]!}画面',
        ),
      ),
      body: FollowList(
        lstUserWithFollow: screenType == ScreenType.follow
            ? userInfo.followeds
            : userInfo.followers,
        screenType: screenType,
      ),
    );
  }
}

class FollowList extends HookConsumerWidget {
  const FollowList({
    Key? key,
    required this.lstUserWithFollow,
    required this.screenType,
  }) : super(key: key);

  final List<UserWithFollow> lstUserWithFollow;
  final ScreenType screenType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(accountControllerProvider);
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final userWithFollow = lstUserWithFollow[index];
              return ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: userWithFollow.user.photoUrl!.isEmpty
                      ? null
                      : NetworkImage(userWithFollow.user.photoUrl!),
                  child: userWithFollow.user.photoUrl!.isEmpty
                      ? const Icon(
                          Icons.person,
                          size: 50,
                        )
                      : null,
                ),
                title: Text(userWithFollow.user.username),
                subtitle: Text(userWithFollow.user.email),
                trailing: screenType == ScreenType.follow
                    ? ElevatedButton(
                        onPressed: () async {
                          await ref
                              .read(accountControllerProvider.notifier)
                              .unFollow(
                                userWithFollow.follow.followId.toString(),
                              );
                        },
                        child: const Text('フォロー解除'),
                      )
                    : userInfo.followeds
                            .map((e) => e.follow.followedUid)
                            .contains(userWithFollow.user.uid)
                        ? ElevatedButton(
                            onPressed: () {
                              ref
                                  .read(accountControllerProvider.notifier)
                                  .unFollow(
                                    userInfo.followeds
                                        .firstWhere((element) =>
                                            element.follow.followedUid ==
                                            userWithFollow.user.uid)
                                        .follow
                                        .followId
                                        .toString(),
                                  );
                            },
                            child: const Text('フォロー解除'),
                          )
                        : ElevatedButton(
                            onPressed: () async {
                              await ref
                                  .read(accountControllerProvider.notifier)
                                  .follow(
                                    userWithFollow.user.uid.toString(),
                                  );
                            },
                            child: const Text('フォローする'),
                          ),
              );
            },
            childCount: lstUserWithFollow.length,
          ),
        ),
      ],
    );
  }
}
