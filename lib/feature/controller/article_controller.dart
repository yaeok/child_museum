import 'package:child_museum/domain/entity/article/article.dart';
import 'package:child_museum/domain/repository/article.dart';
import 'package:child_museum/domain/repository/favorite.dart';
import 'package:child_museum/domain/repository/user.dart';
import 'package:child_museum/feature/controller/state/article/article_state.dart';
import 'package:child_museum/feature/infrastructure/article.dart';
import 'package:child_museum/feature/infrastructure/favorite.dart';
import 'package:child_museum/feature/infrastructure/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ArticleNotifier extends StateNotifier<ArticleState> {
  ArticleNotifier({
    required this.articleRepository,
    required this.favoriteRepository,
    required this.userRepository,
  }) : super(
          const ArticleState(
            articles: [],
          ),
        );

  final ArticleRepository articleRepository;
  final FavoriteRepository favoriteRepository;
  final UserRepository userRepository;
  final _auth = FirebaseAuth.instance;

  Future<void> initialize() async {
    final List<Article> articles = await articleRepository.getArticles();
    List<Article> articlesWithFavoriteUserIds = [];
    for (var article in articles) {
      final favoriteUserIds = await favoriteRepository
          .getFavoritesCountByArticleId(article.articleId!);
      final articleWithOwnerName =
          await userRepository.getUser(article.ownerId);
      articlesWithFavoriteUserIds.add(
        article.copyWith(
          favoriteUserIds: favoriteUserIds,
          username: articleWithOwnerName.username,
        ),
      );
    }
    state = state.copyWith(
      articles: articlesWithFavoriteUserIds,
    );
  }

  Future<void> createArticle(String content, List<XFile> imageUrls) async {
    final currentUser = _auth.currentUser;
    await articleRepository
        .createArticle(
      content,
      imageUrls,
      currentUser!.uid,
    )
        .then(
      (article) async {
        final user = await userRepository.getUser(article.ownerId);
        state = state.copyWith(
          articles: [
            ...state.articles,
            article.copyWith(username: user.username)
          ],
        );
      },
    );
  }

  Future<void> tapFavorite(String articleId) async {
    final currentUser = _auth.currentUser;
    final isFavorite = state.articles
        .where((element) => element.articleId == articleId)
        .first
        .favoriteUserIds
        .any((element) => element == currentUser!.uid);
    if (isFavorite) {
      await favoriteRepository.deleteFavorite(articleId, currentUser!.uid);
      state = state.copyWith(
        articles: state.articles.map((article) {
          if (article.articleId == articleId) {
            return article.copyWith(
              favoriteUserIds: article.favoriteUserIds
                  .where((element) => element != currentUser.uid)
                  .toList(),
            );
          }
          return article;
        }).toList(),
      );
    } else {
      await favoriteRepository.createFavorite(articleId, currentUser!.uid);
      state = state.copyWith(
        articles: state.articles.map((article) {
          if (article.articleId == articleId) {
            return article.copyWith(
              favoriteUserIds: [...article.favoriteUserIds, currentUser.uid],
            );
          }
          return article;
        }).toList(),
      );
    }
  }
}

final articleControllerProvider =
    StateNotifierProvider.autoDispose<ArticleNotifier, ArticleState>(
  (ref) {
    return ArticleNotifier(
      articleRepository: ref.watch(articleRepositoryProvider),
      favoriteRepository: ref.watch(favoriteRepositoryProvider),
      userRepository: ref.watch(userRepositoryProvider),
    );
  },
);
