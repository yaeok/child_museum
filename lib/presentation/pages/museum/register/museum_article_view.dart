import 'dart:io';

import 'package:child_museum/common/router/router_path.dart';
import 'package:child_museum/feature/controller/article_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class MuseumArticleView extends HookConsumerWidget {
  const MuseumArticleView({
    Key? key,
    required this.imageFiles,
  }) : super(key: key);

  final List<XFile>? imageFiles;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contentFromKey = useMemoized(() => GlobalKey<FormBuilderState>(), []);
    final isContentFormValid = useState<bool>(false);
    FocusScopeNode currentFocus = FocusScope.of(context);

    void updContentFormValidity() {
      final contentValid = contentFromKey.currentState?.validate() ?? false;
      isContentFormValid.value = contentValid;
    }

    return GestureDetector(
      onTap: () {
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () {
                if (isContentFormValid.value) {
                  ref.read(articleControllerProvider.notifier).createArticle(
                      contentFromKey.currentState?.fields['content']?.value,
                      imageFiles!);
                }
                context.go(RouterPath.museumList);
              },
              child: const Text('登録'),
            ),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    if (imageFiles != null)
                      for (final imageFile in imageFiles!)
                        Container(
                          padding: const EdgeInsets.all(4),
                          height: MediaQuery.of(context).size.width * 0.8,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Image.file(File(imageFile.path),
                              fit: BoxFit.cover),
                        ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: FormBuilder(
                  key: contentFromKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: FormBuilderTextField(
                    name: 'content',
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      hintText: '記事内容',
                    ),
                    onChanged: (_) => updContentFormValidity(),
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(errorText: '入力してください'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
