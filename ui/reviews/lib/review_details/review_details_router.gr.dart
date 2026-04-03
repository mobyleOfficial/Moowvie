// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'review_details_router.dart';

class ReviewDetailsRouteArgs {
  const ReviewDetailsRouteArgs({
    this.key,
    required this.movieTitle,
    required this.reviewDate,
    required this.rating,
    required this.posterColorIndex,
  });

  final Key? key;
  final String movieTitle;
  final String reviewDate;
  final double rating;
  final int posterColorIndex;
}

/// generated route for
/// [ReviewDetailsPage]
class ReviewDetailsRoute extends PageRouteInfo<ReviewDetailsRouteArgs> {
  ReviewDetailsRoute({
    required String movieTitle,
    required String reviewDate,
    required double rating,
    required int posterColorIndex,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         ReviewDetailsRoute.name,
         args: ReviewDetailsRouteArgs(
           key: key,
           movieTitle: movieTitle,
           reviewDate: reviewDate,
           rating: rating,
           posterColorIndex: posterColorIndex,
         ),
         initialChildren: children,
       );

  static const String name = 'ReviewDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ReviewDetailsRouteArgs>();
      return ReviewDetailsPage(
        key: args.key,
        movieTitle: args.movieTitle,
        reviewDate: args.reviewDate,
        rating: args.rating,
        posterColorIndex: args.posterColorIndex,
      );
    },
  );
}
