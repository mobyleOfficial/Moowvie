// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'movie_detail_router.dart';

class MovieDetailRouteArgs {
  const MovieDetailRouteArgs({this.key, required this.movieId});

  final Key? key;
  final int movieId;
}

/// generated route for
/// [MovieDetailPage]
class MovieDetailRoute extends PageRouteInfo<MovieDetailRouteArgs> {
  MovieDetailRoute({
    required int movieId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          MovieDetailRoute.name,
          args: MovieDetailRouteArgs(key: key, movieId: movieId),
          initialChildren: children,
        );

  static const String name = 'MovieDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MovieDetailRouteArgs>();
      return MovieDetailPage(
        key: args.key,
        movieId: args.movieId,
        getMovieDetail: GetIt.instance<GetMovieDetail>(),
      );
    },
  );
}
