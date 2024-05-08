import 'package:child_museum/feature/controller/comment_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CommentModalBottomSheet extends HookConsumerWidget {
  final String artcileId;

  const CommentModalBottomSheet({
    Key? key,
    required this.artcileId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textEditingController = useTextEditingController();
    final comments = ref.watch(commentControllerProvider).comments;
    final isLoading = useState<bool>(true);

    useEffect(() {
      Future<void> initAsync() async {
        await ref
            .read(commentControllerProvider.notifier)
            .initialize(artcileId);
        isLoading.value = false;
      }

      initAsync();
    }, const []);

    if (isLoading.value) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            bottom:
                MediaQuery.of(context).viewInsets.bottom, // キーボードの高さに応じたパディング
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: comments.isNotEmpty
                    ? ListView.builder(
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(comments[index].comment),
                            subtitle: Text(comments[index].username!),
                            trailing: IconButton(
                              icon: const Icon(Icons.more_horiz),
                              onPressed: () {},
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text(
                          'コメントはありません',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey[300]!,
                    ),
                  ),
                ),
                child: FormBuilderTextField(
                  name: 'comment',
                  textAlignVertical: TextAlignVertical.center,
                  controller: textEditingController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'コメントする',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    suffixIcon: IconButton(
                      onPressed: () {
                        ref
                            .read(commentControllerProvider.notifier)
                            .createComment(
                              artcileId,
                              textEditingController.text,
                            );
                        textEditingController.clear();
                      },
                      icon: const Icon(Icons.send),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void show(
      BuildContext context, List<String> comments, String artcileId) {
    showBarModalBottomSheet(
      context: context,
      expand: true,
      isDismissible: true,
      builder: (context) => CommentModalBottomSheet(
        artcileId: artcileId,
      ),
    );
  }
}
