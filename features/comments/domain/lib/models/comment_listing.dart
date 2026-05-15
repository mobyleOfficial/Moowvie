import 'package:comments_domain/models/comment.dart';

class CommentListing {
  final List<Comment> comments;
  final int totalCount;
  final bool hasMore;

  const CommentListing({
    required this.comments,
    required this.totalCount,
    required this.hasMore,
  });
}
