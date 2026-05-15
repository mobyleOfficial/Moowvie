import 'package:core/core.dart';
import 'package:movies/movies.dart';

sealed class ReviewDetailsState {
  const ReviewDetailsState();
}

class ReviewDetailsLoading extends ReviewDetailsState {
  const ReviewDetailsLoading();
}

class ReviewDetailsError extends ReviewDetailsState {
  final String message;
  const ReviewDetailsError(this.message);
}

/// Primary review details state. Each secondary section is modelled as a
/// nullable [Result] — `null` means "in-flight", `Success` means "data ready",
/// and `Failure` means "show inline error + retry row".
class ReviewDetailsSuccess extends ReviewDetailsState {
  final MovieReview review;
  final bool isLikeBusy;
  final Result<MovieReviewCommentListing>? comments;
  final Result<List<MovieReview>>? otherReviewsForMovie;
  final Result<List<MovieReview>>? moreFromAuthor;

  const ReviewDetailsSuccess({
    required this.review,
    this.isLikeBusy = false,
    this.comments,
    this.otherReviewsForMovie,
    this.moreFromAuthor,
  });

  ReviewDetailsSuccess copyWith({
    MovieReview? review,
    bool? isLikeBusy,
    Result<MovieReviewCommentListing>? comments,
    Result<List<MovieReview>>? otherReviewsForMovie,
    Result<List<MovieReview>>? moreFromAuthor,
    bool clearComments = false,
    bool clearOtherReviewsForMovie = false,
    bool clearMoreFromAuthor = false,
  }) =>
      ReviewDetailsSuccess(
        review: review ?? this.review,
        isLikeBusy: isLikeBusy ?? this.isLikeBusy,
        comments: clearComments ? null : (comments ?? this.comments),
        otherReviewsForMovie: clearOtherReviewsForMovie
            ? null
            : (otherReviewsForMovie ?? this.otherReviewsForMovie),
        moreFromAuthor: clearMoreFromAuthor
            ? null
            : (moreFromAuthor ?? this.moreFromAuthor),
      );
}

/// Transient side-effect state emitted exactly once when a like/unlike
/// optimistic update has been reverted. The screen catches it via a
/// `BlocListener` to show a SnackBar, then the cubit immediately re-emits
/// the underlying [base] success.
class ReviewDetailsLikeFailed extends ReviewDetailsState {
  final ReviewDetailsSuccess base;
  const ReviewDetailsLikeFailed(this.base);
}
