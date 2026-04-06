import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movie_review/movie_review_bloc.dart';
import 'package:movie_review/movie_review_screen.dart';

@RoutePage()
class MovieReviewPage extends StatefulWidget {
  final String movieTitle;
  final String posterPath;

  const MovieReviewPage({
    super.key,
    required this.movieTitle,
    required this.posterPath,
  });

  @override
  State<MovieReviewPage> createState() => _MovieReviewPageState();
}

class _MovieReviewPageState extends State<MovieReviewPage> {
  final MovieReviewCubit _cubit = MovieReviewCubit();

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MovieReviewScreen(
        cubit: _cubit,
        movieTitle: widget.movieTitle,
        posterPath: widget.posterPath,
      );
}
