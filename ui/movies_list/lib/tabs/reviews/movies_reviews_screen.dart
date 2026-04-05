import 'package:auto_route/auto_route.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_detail/movie_detail_router.dart';
import 'package:movies/movies.dart';
import 'package:reviews/reviews_list/reviews_bloc.dart';

class MoviesReviewsScreen extends StatefulWidget {
  final GetMovieReviews getMovieReviews;

  const MoviesReviewsScreen({super.key, required this.getMovieReviews});

  @override
  State<MoviesReviewsScreen> createState() => _MoviesReviewsScreenState();
}

class _MoviesReviewsScreenState extends State<MoviesReviewsScreen> {
  late final ReviewsCubit _cubit = ReviewsCubit(widget.getMovieReviews);

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final posterColors = [
      colorScheme.tertiaryContainer,
      colorScheme.primaryContainer,
      colorScheme.secondaryContainer,
      colorScheme.surfaceContainerHighest,
    ];

    return PagingListener(
      controller: _cubit.pagingController,
      builder: (context, pagingState, fetchNextPage) =>
          PagedListView<int, MovieReview>(
        state: pagingState,
        fetchNextPage: fetchNextPage,
        padding: const EdgeInsets.symmetric(vertical: 8),
        builderDelegate: PagedChildBuilderDelegate<MovieReview>(
          itemBuilder: (context, review, index) => Column(
            children: [
              if (index > 0)
                Divider(
                  indent: 72,
                  height: 1,
                  color: colorScheme.outlineVariant,
                ),
              _ReviewTile(
                review: review,
                posterColor: posterColors[index % posterColors.length],
              ),
            ],
          ),
          firstPageProgressIndicatorBuilder: (_) =>
              const Center(child: CircularProgressIndicator()),
          firstPageErrorIndicatorBuilder: (_) => Center(
            child: Text(AppLocalizations.of(context)!.unknownError),
          ),
        ),
      ),
    );
  }
}

class _ReviewTile extends StatelessWidget {
  final MovieReview review;
  final Color posterColor;

  const _ReviewTile({
    required this.review,
    required this.posterColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final ratingLabel = review.rating % 1 == 0
        ? '${review.rating.toInt()} out of 5 stars'
        : '${review.rating} out of 5 stars';

    return Semantics(
      label: '${review.title}, ${review.date}, $ratingLabel',
      button: true,
      child: InkWell(
        onTap: () =>
            context.router.root.push(MovieDetailRoute(movieId: review.id)),
        child: ExcludeSemantics(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 64,
                  decoration: BoxDecoration(
                    color: posterColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.title,
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        review.date,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: List.generate(5, (starIndex) {
                          final isFilled =
                              starIndex < review.rating.floor();
                          final isHalf =
                              !isFilled && starIndex < review.rating;
                          return Icon(
                            isHalf
                                ? Icons.star_half
                                : (isFilled
                                    ? Icons.star
                                    : Icons.star_border),
                            size: 14,
                            color: colorScheme.onTertiaryContainer,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
