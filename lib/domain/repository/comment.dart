import 'package:child_museum/domain/entity/comment/comment.dart';

abstract class CommentRepository {
  Future<Comment> createComment(
      String articleId, String comment, String ownerId);
  Future<void> deleteComment(String commentId);
  Future<List<Comment>> getCommentByArticleId(String articleId);
}
