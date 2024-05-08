import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite.freezed.dart';

@freezed
class Favorite with _$Favorite {
  const factory Favorite({
    String? favoriteId,
    required String articleId,
    required String userId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Favorite;
}
