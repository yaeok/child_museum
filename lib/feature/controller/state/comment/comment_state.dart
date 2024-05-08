import 'package:child_museum/domain/entity/comment/comment.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_state.freezed.dart';

@freezed
class CommentState with _$CommentState {
  const factory CommentState({
    @Default([]) List<Comment> comments,
  }) = _CommentState;
}
