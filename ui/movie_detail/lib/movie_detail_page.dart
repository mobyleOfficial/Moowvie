import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movies/movies.dart';

import 'package:movie_detail/movie_detail_bloc.dart';
import 'package:movie_detail/movie_detail_screen.dart';

@RoutePage()
class MovieDetailPage extends StatefulWidget {
  final GetMovieDetail getMovieDetail;
  final int movieId;

  const MovieDetailPage({
    super.key,
    required this.getMovieDetail,
    required this.movieId,
  });

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late final MovieDetailCubit _cubit =
      MovieDetailCubit(widget.getMovieDetail, widget.movieId);

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MovieDetailScreen(cubit: _cubit);
  }
}
