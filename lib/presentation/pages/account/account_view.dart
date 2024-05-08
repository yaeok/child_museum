import 'dart:io';

import 'package:child_museum/common/router/router_path.dart';
import 'package:child_museum/feature/controller/account_controller.dart';
import 'package:child_museum/feature/controller/auth_controller.dart';
import 'package:child_museum/presentation/pages/account/enum/screen_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class AccountView extends HookConsumerWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagePicker = useMemoized(() => ImagePicker());
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
      appBar: AppBar(),
      endDrawer: const EndDrawerWidgets(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () async {
                        final XFile? pickedImages = await imagePicker.pickImage(
                            source: ImageSource.gallery);
                        if (pickedImages != null) {
                          ref
                              .read(accountControllerProvider.notifier)
                              .uploadImage(pickedImages);
                        } else {
                          return;
                        }
                      },
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: userInfo.user.photoUrl!.isEmpty
                            ? null
                            : NetworkImage(userInfo.user.photoUrl!),
                        child: userInfo.user.photoUrl!.isEmpty
                            ? const Icon(
                                Icons.person,
                                size: 50,
                              )
                            : null,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                userInfo.articles.length.toString(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                '件の投稿',
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              context.go(RouterPath.followListRoute,
                                  extra: ScreenType.follower);
                            },
                            child: Column(
                              children: [
                                Text(
                                  userInfo.followers.length.toString(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  '人のフォロワー',
                                  style: TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              context.go(RouterPath.followListRoute,
                                  extra: ScreenType.follow);
                            },
                            child: Column(
                              children: [
                                Text(
                                  userInfo.followeds.length.toString(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  '人をフォロー中',
                                  style: TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Text(
                userInfo.user.username,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('アカウント情報の編集'),
              ),
            ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final imagePath = userInfo.articles[index].imageUrls.first;
                return InkWell(
                  onTap: () {},
                  child: SizedBox(
                    height: MediaQuery.of(context).size.width * 0.8,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Image.network(imagePath, fit: BoxFit.cover),
                  ),
                );
              },
              childCount: userInfo.articles.length,
            ),
          ),
        ],
      ),
    );
  }
}

// Drawer Widgetsはこの画面でのみ使用するため、このファイル内に記述

class EndDrawerWidgets extends HookConsumerWidget {
  const EndDrawerWidgets({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: const Text('ユーザを検索する'),
            onTap: () {
              context.go(RouterPath.searchRoute);
            },
          ),
          ListTile(
            title: const Text('利用規約'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('プライバシーポリシー'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('サインアウト'),
            onTap: () {
              ref.read(authControllerProvider.notifier).signOut();
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('退会する'),
            onTap: () {
              ref.read(authControllerProvider.notifier).deleteUser();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
