import 'package:core/core.dart';

import 'package:movies_domain/repositories/movies_repository.dart';

class UnlikeReview extends UseCase<String, Result<void>> {
  final MoviesRepository _moviesRepository;

  UnlikeReview(this._moviesRepository);

  @override
  Future<Result<void>> call([String? params]) async =>
      _moviesRepository.unlikeReview(reviewId: params ?? '');
}
