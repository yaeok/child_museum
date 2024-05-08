import 'package:child_museum/domain/entity/article/article.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_state.freezed.dart';

@freezed
class ArticleState with _$ArticleState {
  const factory ArticleState({
    @Default([]) List<Article> articles,
  }) = _ArticleState;
}
