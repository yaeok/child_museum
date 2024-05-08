import 'package:child_museum/domain/entity/comment/comment.dart';
import 'package:child_museum/domain/repository/comment.dart';
import 'package:child_museum/domain/repository/user.dart';
import 'package:child_museum/feature/controller/state/comment/comment_state.dart';
import 'package:child_museum/feature/infrastructure/comment.dart';
import 'package:child_museum/feature/infrastructure/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CommentNotifier extends StateNotifier<CommentState> {
  CommentNotifier({
    required this.commentRepository,
    required this.userRepository,
  }) : super(const CommentState(comments: []));

  final CommentRepository commentRepository;
  final UserRepository userRepository;

  Future<void> initialize(String articleId) async {
    final comments = await commentRepository.getCommentByArticleId(articleId);
    List<Comment> commentsWithUsername = [];
    for (var comment in comments) {
      final user = await userRepository.getUser(comment.userId);
      commentsWithUsername.add(
        comment.copyWith(
          username: user.username,
        ),
      );
    }
    state = state.copyWith(
      comments: commentsWithUsername,
    );
  }

  Future<void> createComment(String articleId, String comment) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    await commentRepository
        .createComment(
      articleId,
      comment,
      currentUser!.uid,
    )
        .then(
      (comment) async {
        final user = await userRepository.getUser(comment.userId);
        state = state.copyWith(
          comments: [
            ...state.comments,
            comment.copyWith(
              username: user.username,
            ),
          ],
        );
      },
    );
  }
}

final commentControllerProvider =
    StateNotifierProvider<CommentNotifier, CommentState>(
  (ref) {
    return CommentNotifier(
      commentRepository: ref.watch(commentRepositoryProvider),
      userRepository: ref.watch(userRepositoryProvider),
    );
  },
);
