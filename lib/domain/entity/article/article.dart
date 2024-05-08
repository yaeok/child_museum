import 'package:freezed_annotation/freezed_annotation.dart';

part 'article.freezed.dart';

@freezed
class Article with _$Article {
  const factory Article({
    String? articleId,
    required String content,
    required List<String> imageUrls,
    @Default([]) List<String> favoriteUserIds,
    required String ownerId,
    String? username,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) = _Article;
}
