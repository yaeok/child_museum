import 'package:child_museum/domain/entity/favorite/favorite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteMapper {
  static Favorite fromJSON(Map<String, dynamic> json) {
    final createdAt = json['createdAt'] as Timestamp;
    final updatedAt = json['updatedAt'] as Timestamp;
    return Favorite(
      favoriteId: json['favoriteId'] as String?,
      articleId: json['articleId'] as String,
      userId: json['userId'] as String,
      createdAt: createdAt.toDate(),
      updatedAt: updatedAt.toDate(),
    );
  }

  static Map<String, dynamic> toJSON(Favorite favorite) {
    return {
      'favoriteId': favorite.favoriteId,
      'articleId': favorite.articleId,
      'userId': favorite.userId,
      'createdAt': Timestamp.fromDate(favorite.createdAt),
      'updatedAt': Timestamp.fromDate(favorite.updatedAt),
    };
  }
}
