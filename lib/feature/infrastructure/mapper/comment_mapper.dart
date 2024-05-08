import 'package:child_museum/domain/entity/comment/comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentMapper {
  static Comment fromJSON(Map<String, dynamic> json) {
    final createdAt = json['createdAt'] as Timestamp;
    final updatedAt = json['updatedAt'] as Timestamp;
    final deletedAt = json['deletedAt'] as Timestamp?;
    return Comment(
      commentId: json['commentId'] as String,
      articleId: json['articleId'] as String,
      comment: json['comment'] as String,
      userId: json['userId'] as String,
      createdAt: createdAt.toDate(),
      updatedAt: updatedAt.toDate(),
      deletedAt: deletedAt?.toDate(),
    );
  }

  static Map<String, dynamic> toJSON(Comment comment) {
    return {
      'commentId': comment.commentId,
      'articleId': comment.articleId,
      'comment': comment.comment,
      'userId': comment.userId,
      'createdAt': Timestamp.fromDate(comment.createdAt),
      'updatedAt': Timestamp.fromDate(comment.updatedAt),
      'deletedAt': comment.deletedAt != null
          ? Timestamp.fromDate(comment.deletedAt!)
          : null,
    };
  }
}
