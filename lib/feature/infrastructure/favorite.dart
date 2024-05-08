import 'package:child_museum/domain/entity/favorite/favorite.dart';
import 'package:child_museum/domain/repository/favorite.dart';
import 'package:child_museum/feature/infrastructure/firebase/firestore.dart';
import 'package:child_museum/feature/infrastructure/mapper/favorite_mapper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IFavoriteRepository implements FavoriteRepository {
  IFavoriteRepository();

  final _favorite = Firestore.favorite;

  @override
  Future<void> createFavorite(String articleId, String ownerId) async {
    final docId = _favorite.doc().id;
    final favorite = Favorite(
      favoriteId: docId,
      articleId: articleId,
      userId: ownerId,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await _favorite.doc(docId).set(FavoriteMapper.toJSON(favorite));
  }

  @override
  Future<void> deleteFavorite(String articleId, String ownerId) async {
    final docId = await _favorite
        .where('articleId', isEqualTo: articleId)
        .where('userId', isEqualTo: ownerId)
        .get()
        .then((value) => value.docs.first.id);

    await _favorite.doc(docId).delete();
  }

  @override
  Future<List<String>> getFavoritesCountByArticleId(String articleId) async {
    return await _favorite
        .where('articleId', isEqualTo: articleId)
        .get()
        .then((value) {
      return value.docs.map((e) {
        final favorite = FavoriteMapper.fromJSON(e.data());
        return favorite.userId;
      }).toList();
    });
  }
}

final favoriteRepositoryProvider = Provider<FavoriteRepository>((ref) {
  return IFavoriteRepository();
});
