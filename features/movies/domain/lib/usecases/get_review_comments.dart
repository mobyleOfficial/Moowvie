import 'package:core/core.dart';

import 'package:movies_domain/models/movie_review_comment_listing.dart';
import 'package:movies_domain/repositories/movies_repository.dart';

class GetReviewCommentsParams {
  final String reviewId;
  final int page;

  const GetReviewCommentsParams({required this.reviewId, required this.page});
}

class GetReviewComments
    extends UseCase<GetReviewCommentsParams, Result<MovieReviewCommentListing>> {
  final MoviesRepository _moviesRepository;

  GetReviewComments(this._moviesRepository);

  @override
  Future<Result<MovieReviewCommentListing>> call([
    GetReviewCommentsParams? params,
  ]) async =>
      _moviesRepository.getReviewComments(
        reviewId: params?.reviewId ?? '',
        page: params?.page ?? 1,
      );
}
