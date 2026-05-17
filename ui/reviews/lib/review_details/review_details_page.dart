import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/movies.dart';
import 'package:reviews/review_details/review_details_bloc.dart';
import 'package:reviews/review_details/review_details_screen.dart';

@RoutePage()
class ReviewDetailsPage extends StatefulWidget {
  final String reviewId;
  final String movieTitle;

  const ReviewDetailsPage({
    super.key,
    required this.reviewId,
    required this.movieTitle,
  });

  @override
  State<ReviewDetailsPage> createState() => _ReviewDetailsPageState();
}

class _ReviewDetailsPageState extends State<ReviewDetailsPage> {
  late final ReviewDetailsCubit _cubit = ReviewDetailsCubit(
    reviewId: widget.reviewId,
    getReviewDetails: GetIt.I<GetReviewDetails>(),
    getMovieReviews: GetIt.I<GetMovieReviews>(),
    likeReview: GetIt.I<LikeReview>(),
    unlikeReview: GetIt.I<UnlikeReview>(),
  );

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ReviewDetailsScreen(cubit: _cubit);
}
