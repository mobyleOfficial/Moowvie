import 'package:movies_domain/models/movie_review_comment.dart';

class MovieReviewCommentListing {
  final int page;
  final int totalPages;
  final int totalResults;
  final List<MovieReviewComment> comments;

  const MovieReviewCommentListing({
    required this.page,
    required this.totalPages,
    required this.totalResults,
    required this.comments,
  });
}
