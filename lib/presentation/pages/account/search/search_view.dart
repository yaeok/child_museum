import 'package:child_museum/domain/entity/user/user.dart';
import 'package:child_museum/feature/controller/account_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchView extends HookConsumerWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final search = ref.watch(accountControllerProvider);
    final textEditingController = useTextEditingController();
    final resultUser = useState<List<User>>([]);

    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: 8.h,
                horizontal: 8.w,
              ),
              decoration: BoxDecoration(
                // color: ThemeColor.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  // color: ThemeColor.secondary,
                  width: 1,
                ),
              ),
              child: TextFormField(
                // cursorColor: ThemeColor.primary,
                controller: textEditingController,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'ユーザを探す',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  suffixIcon: TextButton(
                    onPressed: () async {
                      if (textEditingController.text == search.user.email) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('自分自身は検索できません'),
                          ),
                        );
                        return;
                      }
                      resultUser.value = await ref
                          .read(accountControllerProvider.notifier)
                          .searchUserByEmail(textEditingController.text);
                    },
                    child: const Text('検索'),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final userInfo = resultUser.value[index];
                return ListTile(
                  leading: userInfo.photoUrl!.isEmpty
                      ? null
                      : CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(userInfo.photoUrl!),
                        ),
                  title: Text(userInfo.username),
                  subtitle: Text(userInfo.email),
                  trailing: search.followeds
                          .map((e) => e.follow.followedUid)
                          .toList()
                          .contains(userInfo.uid)
                      ? ElevatedButton(
                          onPressed: () {
                            ref
                                .read(accountControllerProvider.notifier)
                                .unFollow(search.followeds
                                    .firstWhere((element) =>
                                        element.user.uid == userInfo.uid)
                                    .follow
                                    .followId
                                    .toString());
                          },
                          child: const Text('フォロー中'),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            ref
                                .read(accountControllerProvider.notifier)
                                .follow(userInfo.uid);
                          },
                          child: const Text('フォローする'),
                        ),
                );
              },
              childCount: resultUser.value.length,
            ),
          ),
        ],
      ),
    );
  }
}
