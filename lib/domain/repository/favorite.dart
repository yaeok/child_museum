abstract class FavoriteRepository {
  Future<void> createFavorite(String articleId, String ownerId);
  Future<void> deleteFavorite(String articleId, String ownerId);
  Future<List<String>> getFavoritesCountByArticleId(String articleId);
}
