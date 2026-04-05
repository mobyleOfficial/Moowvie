import 'package:movies_domain/models/movie_review.dart';

class MovieReviewListing {
  final int totalPages;
  final int totalResults;
  final List<MovieReview> reviews;

  const MovieReviewListing({
    required this.totalPages,
    required this.totalResults,
    required this.reviews,
  });
}
