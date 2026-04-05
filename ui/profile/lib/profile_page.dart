import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movies/movies.dart';
import 'package:profile_ui/profile_screen.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  final GetMovieReviews getMovieReviews;
  final GetMovieCollections getMovieCollections;

  const ProfilePage({
    super.key,
    required this.getMovieReviews,
    required this.getMovieCollections,
  });

  @override
  Widget build(BuildContext context) => ProfileScreen(
        getMovieReviews: getMovieReviews,
        getMovieCollections: getMovieCollections,
      );
}
