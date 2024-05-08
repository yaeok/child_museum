import 'package:child_museum/domain/entity/comment/comment.dart';
import 'package:child_museum/domain/repository/comment.dart';
import 'package:child_museum/feature/infrastructure/firebase/firestore.dart';
import 'package:child_museum/feature/infrastructure/mapper/comment_mapper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ICommentRepository implements CommentRepository {
  ICommentRepository();

  final _commentDB = Firestore.comment;

  @override
  Future<Comment> createComment(
      String articleId, String comment, String ownerId) async {
    final docId = _commentDB.doc().id;
    final regComment = Comment(
      commentId: docId,
      articleId: articleId,
      comment: comment,
      userId: ownerId,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await _commentDB.doc(docId).set(CommentMapper.toJSON(regComment));
    return regComment;
  }

  @override
  Future<void> deleteComment(String commentId) {
    return _commentDB.doc(commentId).delete();
  }

  @override
  Future<List<Comment>> getCommentByArticleId(String articleId) {
    return _commentDB
        .where('articleId', isEqualTo: articleId)
        .get()
        .then((value) {
      return value.docs.map((e) {
        final comment = CommentMapper.fromJSON(e.data());
        return comment;
      }).toList();
    });
  }
}

final commentRepositoryProvider = Provider<ICommentRepository>(
  (ref) => ICommentRepository(),
);
