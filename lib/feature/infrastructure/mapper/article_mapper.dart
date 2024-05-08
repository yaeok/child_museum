import 'package:child_museum/domain/entity/article/article.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ArticleMapper {
  static Article fromJSON(Map<String, dynamic> json) {
    final createdAt = json['createdAt'] as Timestamp;
    final updatedAt = json['updatedAt'] as Timestamp;
    final deletedAt = json['deletedAt'] as Timestamp?;
    return Article(
      articleId: json['articleId'] as String,
      content: json['content'] as String,
      imageUrls: List<String>.from(json['imageUrls']),
      ownerId: json['ownerId'] as String,
      createdAt: createdAt.toDate(),
      updatedAt: updatedAt.toDate(),
      deletedAt: deletedAt?.toDate(),
    );
  }

  static Map<String, dynamic> toJSON(Article article) {
    return {
      'articleId': article.articleId,
      'content': article.content,
      'imageUrls': article.imageUrls,
      'ownerId': article.ownerId,
      'createdAt': Timestamp.fromDate(article.createdAt),
      'updatedAt': Timestamp.fromDate(article.updatedAt),
      'deletedAt': article.deletedAt != null
          ? Timestamp.fromDate(article.deletedAt!)
          : null,
    };
  }
}
