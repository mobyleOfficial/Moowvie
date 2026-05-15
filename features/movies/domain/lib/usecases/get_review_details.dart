import 'package:core/core.dart';

import 'package:movies_domain/models/movie_review.dart';
import 'package:movies_domain/repositories/movies_repository.dart';

class GetReviewDetails extends UseCase<String, Result<MovieReview>> {
  final MoviesRepository _moviesRepository;

  GetReviewDetails(this._moviesRepository);

  @override
  Future<Result<MovieReview>> call([String? params]) async =>
      _moviesRepository.getReviewDetails(reviewId: params ?? '');
}
