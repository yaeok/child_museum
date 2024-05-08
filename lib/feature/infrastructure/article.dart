import 'dart:io';

import 'package:child_museum/domain/entity/article/article.dart';
import 'package:child_museum/domain/repository/article.dart';
import 'package:child_museum/feature/infrastructure/firebase/firestore.dart';
import 'package:child_museum/feature/infrastructure/mapper/article_mapper.dart';
import 'package:child_museum/feature/infrastructure/util/image_compressor.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class IArticleRepository implements ArticleRepository {
  IArticleRepository();

  final _articleDB = Firestore.article;

  @override
  Future<Article> createArticle(
    String content,
    List<XFile> imageUrls,
    String ownerId,
  ) async {
    try {
      final docId = _articleDB.doc().id;
      final strImageUrls = await IArticleRepository._uploadImage(
        images: imageUrls,
        articleId: docId,
      );
      final recArticle = Article(
        articleId: docId,
        content: content,
        imageUrls: strImageUrls,
        ownerId: ownerId,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await _articleDB.doc(docId).set(ArticleMapper.toJSON(recArticle));

      return recArticle;
    } catch (e) {
      throw Exception('Failed to create article$e');
    }
  }

  @override
  Future<void> deleteArticle(String articleId) async {
    try {
      await _articleDB.doc(articleId).delete();
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<Article> getArticle(String articleId) async {
    return await _articleDB.doc(articleId).get().then(
      (doc) {
        if (doc.exists) {
          return ArticleMapper.fromJSON(doc.data()!);
        } else {
          throw Exception('Article not found');
        }
      },
    );
  }

  @override
  Future<List<Article>> getArticles() async {
    return await _articleDB.get().then(
      (querySnapshot) {
        return querySnapshot.docs
            .map((doc) => ArticleMapper.fromJSON(doc.data()))
            .toList();
      },
    );
  }

  @override
  Future<void> updateArticle(Article article) {
    final updArticle = article.copyWith(updatedAt: DateTime.now());
    return _articleDB
        .doc(article.articleId)
        .update(ArticleMapper.toJSON(updArticle));
  }

  @override
  Future<List<Article>> getArticlesByOwnerId(String ownerId) async {
    return await _articleDB.where('ownerId', isEqualTo: ownerId).get().then(
      (querySnapshot) {
        return querySnapshot.docs
            .map((doc) => ArticleMapper.fromJSON(doc.data()))
            .toList();
      },
    );
  }

  static Future<List<String>> _uploadImage(
      {required List<XFile> images, required String articleId}) async {
    try {
      List<String> imageUrl = [];
      for (final image in images) {
        final fileName = image.name;
        final data = await ImageCompressor().compress(
          File(image.path).readAsBytesSync(),
          1 * 1024 * 1024,
        );
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('articles/$articleId/$fileName');
        await storageRef.putData(data);
        final url = await storageRef.getDownloadURL();
        imageUrl.add(url);
      }
      return imageUrl;
    } catch (e) {
      throw Exception('Failed to upload image$e');
    }
  }
}

final articleRepositoryProvider = Provider<IArticleRepository>(
  (ref) => IArticleRepository(),
);
