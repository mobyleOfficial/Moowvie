class MovieReviewComment {
  final String id;
  final String reviewId;
  final String authorId;
  final String authorName;
  final String body;
  final String createdAt;

  const MovieReviewComment({
    required this.id,
    required this.reviewId,
    required this.authorId,
    required this.authorName,
    required this.body,
    required this.createdAt,
  });
}
