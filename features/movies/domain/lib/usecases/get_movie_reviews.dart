import 'package:core/core.dart';

import 'package:movies_domain/models/movie_review_listing.dart';
import 'package:movies_domain/repositories/movies_repository.dart';

class GetMovieReviews extends UseCase<int, Result<MovieReviewListing>> {
  final MoviesRepository _moviesRepository;

  GetMovieReviews(this._moviesRepository);

  @override
  Future<Result<MovieReviewListing>> call([int? params]) async =>
      _moviesRepository.getMovieReviews(page: params ?? 1);
}
