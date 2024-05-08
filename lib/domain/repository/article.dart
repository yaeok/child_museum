import 'package:child_museum/domain/entity/article/article.dart';
import 'package:image_picker/image_picker.dart';

abstract class ArticleRepository {
  Future<Article> createArticle(
      String content, List<XFile> imageUrls, String ownerId);
  Future<void> updateArticle(Article article);
  Future<void> deleteArticle(String articleId);
  Future<List<Article>> getArticles();
  Future<Article> getArticle(String articleId);
  Future<List<Article>> getArticlesByOwnerId(String ownerId);
}
