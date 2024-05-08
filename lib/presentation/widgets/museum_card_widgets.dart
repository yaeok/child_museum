import 'package:child_museum/common/provider/current_user_provider.dart';
import 'package:child_museum/domain/entity/article/article.dart';
import 'package:child_museum/feature/controller/article_controller.dart';
import 'package:child_museum/presentation/pages/museum/widgets/comment_modal_widgets.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MuseumCardWidgets extends HookConsumerWidget {
  const MuseumCardWidgets({
    Key? key,
    this.comments,
    required this.article,
  }) : super(key: key);

  final List<String>? comments;
  final Article article;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider).value!.uid;
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const CircleAvatar(),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(article.username!),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    print('more button tapped 1');
                  },
                  icon: const Icon(
                    Icons.more_horiz,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width,
            child: PageView(
              children: article.imageUrls
                  .map(
                    (url) => Image.network(
                      url,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      ref
                          .read(articleControllerProvider.notifier)
                          .tapFavorite(article.articleId!);
                    },
                    icon: article.favoriteUserIds.contains(currentUser)
                        ? const Icon(Icons.favorite, color: Colors.pink)
                        : const Icon(Icons.favorite_border_outlined),
                  ),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return CommentModalBottomSheet(
                              artcileId: article.articleId!);
                        },
                      );
                    },
                    icon: const Icon(Icons.comment),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Text(article.content),
          ),
        ],
      ),
    );
  }
}
