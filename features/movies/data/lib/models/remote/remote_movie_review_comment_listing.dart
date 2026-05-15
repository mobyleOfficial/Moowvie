import 'package:movies_domain/domain.dart';

import 'package:movies_data/models/remote/remote_movie_review_comment.dart';

class RemoteMovieReviewCommentListing {
  final int page;
  final int totalPages;
  final int totalResults;
  final List<RemoteMovieReviewComment> comments;

  const RemoteMovieReviewCommentListing({
    required this.page,
    required this.totalPages,
    required this.totalResults,
    required this.comments,
  });

  factory RemoteMovieReviewCommentListing.fromJson(Map<String, dynamic> json) =>
      RemoteMovieReviewCommentListing(
        page: json['page'] as int,
        totalPages: json['total_pages'] as int,
        totalResults: json['total_results'] as int,
        comments: (json['results'] as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map(RemoteMovieReviewComment.fromJson)
            .toList(),
      );

  MovieReviewCommentListing toDomain() => MovieReviewCommentListing(
        page: page,
        totalPages: totalPages,
        totalResults: totalResults,
        comments: comments.map((comment) => comment.toDomain()).toList(),
      );
}
