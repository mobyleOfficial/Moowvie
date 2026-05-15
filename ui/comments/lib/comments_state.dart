import 'package:comments/comments.dart';

sealed class CommentsState {
  const CommentsState();
}

final class CommentsLoading extends CommentsState {
  const CommentsLoading();
}

final class CommentsSuccess extends CommentsState {
  final List<Comment> comments;
  final int totalCount;
  final bool hasMore;
  final int currentPage;

  const CommentsSuccess({
    required this.comments,
    required this.totalCount,
    required this.hasMore,
    required this.currentPage,
  });
}

final class CommentsError extends CommentsState {
  final String message;

  const CommentsError(this.message);
}
