import 'package:movies_domain/domain.dart';

class RemoteMovieReviewComment {
  final String id;
  final String reviewId;
  final String authorId;
  final String authorName;
  final String body;
  final String createdAt;

  const RemoteMovieReviewComment({
    required this.id,
    required this.reviewId,
    required this.authorId,
    required this.authorName,
    required this.body,
    required this.createdAt,
  });

  factory RemoteMovieReviewComment.fromJson(Map<String, dynamic> json) =>
      RemoteMovieReviewComment(
        id: json['id'] as String,
        reviewId: json['review_id'] as String,
        authorId: json['author_id'] as String,
        authorName: json['author_name'] as String,
        body: json['body'] as String,
        createdAt: json['created_at'] as String,
      );

  MovieReviewComment toDomain() => MovieReviewComment(
        id: id,
        reviewId: reviewId,
        authorId: authorId,
        authorName: authorName,
        body: body,
        createdAt: createdAt,
      );
}
