import 'package:comments_domain/models/comment.dart';

class CommentResponse {
  final List<Comment> comments;
  final int totalCount;
  final bool hasMore;

  const CommentResponse({
    required this.comments,
    required this.totalCount,
    required this.hasMore,
  });
}
