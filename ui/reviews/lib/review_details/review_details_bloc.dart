import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:reviews/review_details/review_details_state.dart';

class ReviewDetailsCubit extends Cubit<ReviewDetailsState> {
  final String reviewId;
  final GetReviewDetails _getReviewDetails;
  final GetReviewComments _getReviewComments;
  final GetMovieReviews _getMovieReviews;
  final LikeReview _likeReview;
  final UnlikeReview _unlikeReview;

  ReviewDetailsCubit({
    required this.reviewId,
    required GetReviewDetails getReviewDetails,
    required GetReviewComments getReviewComments,
    required GetMovieReviews getMovieReviews,
    required LikeReview likeReview,
    required UnlikeReview unlikeReview,
  })  : _getReviewDetails = getReviewDetails,
        _getReviewComments = getReviewComments,
        _getMovieReviews = getMovieReviews,
        _likeReview = likeReview,
        _unlikeReview = unlikeReview,
        super(const ReviewDetailsLoading()) {
    load();
  }

  Future<void> load() async {
    emit(const ReviewDetailsLoading());

    final detailsResult = await _getReviewDetails(reviewId);

    switch (detailsResult) {
      case Failure(:final error):
        emit(ReviewDetailsError(error.message));
        return;
      case Success(:final data):
        emit(ReviewDetailsSuccess(review: data));
        await _loadSecondarySections(review: data);
    }
  }

  void reload() => load();

  Future<void> _loadSecondarySections({required MovieReview review}) async {
    await Future.wait<void>([
      _loadComments(),
      _loadOtherReviewsForMovie(review),
      _loadMoreFromAuthor(review),
    ]);
  }

  Future<void> _loadComments() async {
    final result = await _getReviewComments(
      GetReviewCommentsParams(reviewId: reviewId, page: 1),
    );

    final currentState = state;
    if (currentState is ReviewDetailsSuccess) {
      emit(currentState.copyWith(comments: result));
    }
  }

  Future<void> _loadOtherReviewsForMovie(MovieReview review) async {
    final result = await _getMovieReviews(
      GetMovieReviewsParams(page: 1, movieId: review.movieId),
    );

    final filtered = switch (result) {
      Success(:final data) => Success<List<MovieReview>>(
          data.reviews
              .where((other) => other.id != reviewId)
              .take(10)
              .toList(),
        ),
      Failure(:final error) => Failure<List<MovieReview>>(error),
    };

    final currentState = state;
    if (currentState is ReviewDetailsSuccess) {
      emit(currentState.copyWith(otherReviewsForMovie: filtered));
    }
  }

  Future<void> _loadMoreFromAuthor(MovieReview review) async {
    if (review.authorId == null) {
      final currentState = state;
      if (currentState is ReviewDetailsSuccess) {
        emit(currentState.copyWith(
          moreFromAuthor: Success<List<MovieReview>>(const []),
        ));
      }
      return;
    }

    final result = await _getMovieReviews(
      GetMovieReviewsParams(page: 1, userId: review.authorId),
    );

    final filtered = switch (result) {
      Success(:final data) => Success<List<MovieReview>>(
          data.reviews
              .where((other) => other.id != reviewId)
              .take(10)
              .toList(),
        ),
      Failure(:final error) => Failure<List<MovieReview>>(error),
    };

    final currentState = state;
    if (currentState is ReviewDetailsSuccess) {
      emit(currentState.copyWith(moreFromAuthor: filtered));
    }
  }

  Future<void> retryComments() async {
    final currentState = state;
    if (currentState is ReviewDetailsSuccess) {
      emit(currentState.copyWith(clearComments: true));
      await _loadComments();
    }
  }

  Future<void> retryOtherReviewsForMovie() async {
    final currentState = state;
    if (currentState is ReviewDetailsSuccess) {
      emit(currentState.copyWith(clearOtherReviewsForMovie: true));
      await _loadOtherReviewsForMovie(currentState.review);
    }
  }

  Future<void> retryMoreFromAuthor() async {
    final currentState = state;
    if (currentState is ReviewDetailsSuccess) {
      emit(currentState.copyWith(clearMoreFromAuthor: true));
      await _loadMoreFromAuthor(currentState.review);
    }
  }

  Future<void> toggleLike() async {
    final currentState = state;
    if (currentState is! ReviewDetailsSuccess) return;
    if (currentState.isLikeBusy) return;

    final originalReview = currentState.review;
    final wasLiked = originalReview.likedByCurrentUser;
    final optimisticReview = originalReview.copyWith(
      likedByCurrentUser: !wasLiked,
      likeCount: wasLiked
          ? (originalReview.likeCount - 1).clamp(0, 1 << 30)
          : originalReview.likeCount + 1,
    );

    emit(currentState.copyWith(review: optimisticReview, isLikeBusy: true));

    final result = wasLiked
        ? await _unlikeReview(originalReview.id)
        : await _likeReview(originalReview.id);

    final latestState = state;
    if (latestState is! ReviewDetailsSuccess) return;

    switch (result) {
      case Success():
        emit(latestState.copyWith(isLikeBusy: false));
      case Failure():
        final reverted = latestState.copyWith(
          review: originalReview,
          isLikeBusy: false,
        );
        emit(ReviewDetailsLikeFailed(reverted));
        emit(reverted);
    }
  }
}
