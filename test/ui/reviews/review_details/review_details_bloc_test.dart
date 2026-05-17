import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_domain/domain.dart';
import 'package:reviews/review_details/review_details_bloc.dart';
import 'package:reviews/review_details/review_details_state.dart';

import '../../../helpers/fake_movies_repository.dart';

ReviewDetailsCubit _buildCubit({
  required FakeMoviesRepository repository,
  String reviewId = 'r-1-0',
}) =>
    ReviewDetailsCubit(
      reviewId: reviewId,
      getReviewDetails: GetReviewDetails(repository),
      getMovieReviews: GetMovieReviews(repository),
      likeReview: LikeReview(repository),
      unlikeReview: UnlikeReview(repository),
    );

const _sampleReview = MovieReview(
  id: 'r-1-0',
  movieId: 1,
  title: 'Sample',
  date: 'Jan 1, 2024',
  rating: 4.0,
  author: 'Author',
  authorId: 'u-1',
  content: 'Body',
  likeCount: 3,
);

void main() {
  group('ReviewDetailsCubit', () {
    test('emits Loading then Error when primary fetch fails', () async {
      final repository = FakeMoviesRepository()
        ..reviewDetailsResult = const Failure(AppError.notFound);
      final emitted = <ReviewDetailsState>[];
      final cubit = _buildCubit(repository: repository);
      final sub = cubit.stream.listen(emitted.add);

      // Wait for state stream to settle.
      await Future<void>.delayed(const Duration(milliseconds: 50));
      await sub.cancel();
      await cubit.close();

      expect(emitted.last, isA<ReviewDetailsError>());
    });

    test('emits Success then populates secondary sections after primary fetch',
        () async {
      final repository = FakeMoviesRepository()
        ..reviewDetailsResult = const Success(_sampleReview)
        ..movieReviewsResult = const Success(
          MovieReviewListing(totalPages: 1, totalResults: 0, reviews: []),
        );

      final cubit = _buildCubit(repository: repository);
      await Future<void>.delayed(const Duration(milliseconds: 50));
      final finalState = cubit.state;
      await cubit.close();

      expect(finalState, isA<ReviewDetailsSuccess>());
      final success = finalState as ReviewDetailsSuccess;
      expect(success.otherReviewsForMovie, isA<Success<List<MovieReview>>>());
      expect(success.moreFromAuthor, isA<Success<List<MovieReview>>>());
    });

    test('toggleLike optimistic update sticks on success', () async {
      final repository = FakeMoviesRepository()
        ..reviewDetailsResult = const Success(_sampleReview)
        ..movieReviewsResult = const Success(
          MovieReviewListing(totalPages: 1, totalResults: 0, reviews: []),
        )
        ..likeReviewResult = const Success(null);

      final cubit = _buildCubit(repository: repository);
      await Future<void>.delayed(const Duration(milliseconds: 50));
      await cubit.toggleLike();

      final success = cubit.state as ReviewDetailsSuccess;
      expect(success.review.likedByCurrentUser, true);
      expect(success.review.likeCount, 4);
      expect(success.isLikeBusy, false);
      await cubit.close();
    });

    test('toggleLike emits LikeFailed once and reverts on failure', () async {
      final repository = FakeMoviesRepository()
        ..reviewDetailsResult = const Success(_sampleReview)
        ..movieReviewsResult = const Success(
          MovieReviewListing(totalPages: 1, totalResults: 0, reviews: []),
        )
        ..likeReviewResult = const Failure(AppError.server);

      final cubit = _buildCubit(repository: repository);
      await Future<void>.delayed(const Duration(milliseconds: 50));

      final emitted = <ReviewDetailsState>[];
      final sub = cubit.stream.listen(emitted.add);
      await cubit.toggleLike();
      // Allow any pending stream events to be delivered before assertions.
      await Future<void>.delayed(Duration.zero);
      await sub.cancel();

      final likeFailedStates =
          emitted.whereType<ReviewDetailsLikeFailed>().toList();
      expect(likeFailedStates.length, 1);

      final finalState = cubit.state as ReviewDetailsSuccess;
      // Reverted: still 3 likes, not liked.
      expect(finalState.review.likedByCurrentUser, false);
      expect(finalState.review.likeCount, 3);
      await cubit.close();
    });
  });
}
