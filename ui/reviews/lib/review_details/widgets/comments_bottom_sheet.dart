import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies/movies.dart';

class CommentsBottomSheet extends StatefulWidget {
  final String reviewId;

  const CommentsBottomSheet({super.key, required this.reviewId});

  @override
  State<CommentsBottomSheet> createState() => _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends State<CommentsBottomSheet> {
  final GetReviewComments _getReviewComments = GetIt.I<GetReviewComments>();
  int _totalPages = 1;

  late final PagingController<int, MovieReviewComment> _pagingController =
      PagingController<int, MovieReviewComment>(
    getNextPageKey: (state) {
      final nextKey = state.nextIntPageKey;
      if (nextKey > _totalPages) return null;
      return nextKey;
    },
    fetchPage: _fetchPage,
  );

  Future<List<MovieReviewComment>> _fetchPage(int page) async {
    final result = await _getReviewComments(
      GetReviewCommentsParams(reviewId: widget.reviewId, page: page),
    );

    switch (result) {
      case Success(:final data):
        _totalPages = data.totalPages;
        return data.comments;
      case Failure(:final error):
        throw Exception(error.message);
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      maxChildSize: 0.95,
      builder: (context, scrollController) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    l10n?.reviewDetailsCommentsTitle ?? '',
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PagingListener<int, MovieReviewComment>(
              controller: _pagingController,
              builder: (context, pagingState, fetchNextPage) =>
                  PagedListView<int, MovieReviewComment>(
                state: pagingState,
                scrollController: scrollController,
                fetchNextPage: fetchNextPage,
                padding: const EdgeInsets.symmetric(vertical: 8),
                builderDelegate: PagedChildBuilderDelegate<MovieReviewComment>(
                  itemBuilder: (context, comment, index) => Semantics(
                    label: '${comment.authorName}: ${comment.body}',
                    child: ExcludeSemantics(
                      child: ListTile(
                        title: Text(comment.authorName),
                        subtitle: Text(comment.body),
                        trailing: Text(
                          comment.createdAt,
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ),
                  ),
                  firstPageProgressIndicatorBuilder: (_) =>
                      const Center(child: CircularProgressIndicator()),
                  newPageProgressIndicatorBuilder: (_) => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  firstPageErrorIndicatorBuilder: (_) => _InlineRetry(
                    message: l10n?.reviewDetailsLoadCommentsError ?? '',
                    onRetry: () =>
                        _pagingController.refresh(),
                  ),
                  newPageErrorIndicatorBuilder: (_) => _InlineRetry(
                    message: l10n?.reviewDetailsLoadCommentsError ?? '',
                    onRetry: () =>
                        _pagingController.fetchNextPage(),
                  ),
                  noItemsFoundIndicatorBuilder: (_) => Padding(
                    padding: const EdgeInsets.all(24),
                    child: Center(
                      child: Text(l10n?.reviewDetailsNoComments ?? ''),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InlineRetry extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _InlineRetry({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: colorScheme.error),
            ),
          ),
          TextButton(
            onPressed: onRetry,
            child: Text(l10n?.emptyStateRetry ?? ''),
          ),
        ],
      ),
    );
  }
}
