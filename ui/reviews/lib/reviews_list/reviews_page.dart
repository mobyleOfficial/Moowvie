import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movies/movies.dart';
import 'package:reviews/reviews_list/reviews_screen.dart';

@RoutePage()
class ReviewsPage extends StatelessWidget {
  final GetMovieReviews getMovieReviews;

  const ReviewsPage({super.key, required this.getMovieReviews});

  @override
  Widget build(BuildContext context) =>
      ReviewsScreen(getMovieReviews: getMovieReviews);
}
