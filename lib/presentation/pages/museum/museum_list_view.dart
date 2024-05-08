import 'package:child_museum/common/router/router_path.dart';
import 'package:child_museum/feature/controller/article_controller.dart';
import 'package:child_museum/presentation/widgets/museum_card_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MuseumListView extends HookConsumerWidget {
  const MuseumListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articles = ref.watch(articleControllerProvider);
    final isLoading = useState<bool>(true);

    useEffect(() {
      Future<void> init() async {
        await ref.read(articleControllerProvider.notifier).initialize();
        isLoading.value = false;
      }

      init();
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
        actions: [
          IconButton(
            icon: const Icon(Icons.post_add_rounded),
            onPressed: () {
              context.go(RouterPath.museumRegImageRoute);
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.go(RouterPath.accountRoute);
            },
          ),
        ],
      ),
      body: SafeArea(
        bottom: true,
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final article = articles.articles[index];
                return MuseumCardWidgets(
                  article: article,
                  comments: [],
                );
              }, childCount: articles.articles.length),
            ),
          ],
        ),
      ),
    );
  }
}
