import 'package:core/core.dart';

import 'package:movies_domain/repositories/movies_repository.dart';

class LikeReview extends UseCase<String, Result<void>> {
  final MoviesRepository _moviesRepository;

  LikeReview(this._moviesRepository);

  @override
  Future<Result<void>> call([String? params]) async =>
      _moviesRepository.likeReview(reviewId: params ?? '');
}
