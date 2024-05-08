import 'dart:io';
import 'package:child_museum/common/router/router_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class MuseumImageView extends HookConsumerWidget {
  const MuseumImageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagePicker = useMemoized(() => ImagePicker());
    final selectedImages = useState<List<XFile>>([]);
    final currentImage = useState<XFile?>(null);

    Future<void> pickImages() async {
      final List<XFile> pickedImages = await imagePicker.pickMultiImage();
      selectedImages.value = pickedImages;
      if (pickedImages.isNotEmpty) currentImage.value = pickedImages.first;
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.add_a_photo),
            onPressed: pickImages,
          ),
          TextButton(
            onPressed: selectedImages.value.isEmpty
                ? null
                : () {
                    context.go(RouterPath.museumRegArticleRoute,
                        extra: selectedImages.value);
                  },
            child: const Text('次へ'),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: currentImage.value != null
                ? Container(
                    padding: const EdgeInsets.all(4),
                    height: MediaQuery.of(context).size.width,
                    child: Image.file(File(currentImage.value!.path),
                        fit: BoxFit.cover),
                  )
                : Container(
                    padding: const EdgeInsets.all(4),
                    height: MediaQuery.of(context).size.width,
                    color: Colors.grey[300],
                    child: const Center(child: Text('No Image Selected')),
                  ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final file = selectedImages.value[index];
                return GestureDetector(
                  onTap: () {
                    currentImage.value =
                        file; // Update the selected image to display
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: currentImage.value == file
                            ? Colors.blue
                            : Colors.transparent,
                        width: 3,
                      ),
                    ),
                    child: Image.file(File(file.path), fit: BoxFit.cover),
                  ),
                );
              },
              childCount: selectedImages.value.length,
            ),
          ),
        ],
      ),
    );
  }
}
