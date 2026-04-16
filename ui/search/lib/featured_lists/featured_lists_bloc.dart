import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies/movies.dart';

import 'package:search/featured_lists/featured_lists_state.dart';

class FeaturedListsCubit extends Cubit<FeaturedListsState> {
  final GetFeaturedLists _getFeaturedLists;

  int _totalPages = 1;

  late final PagingController<int, MovieList> pagingController = PagingController(
    getNextPageKey: (state) {
      final nextKey = state.nextIntPageKey;
      if (nextKey > _totalPages) return null;
      return nextKey;
    },
    fetchPage: _fetchPage,
  );

  FeaturedListsCubit(this._getFeaturedLists)
      : super(const FeaturedListsLoading());

  Future<List<MovieList>> _fetchPage(int page) async {
    final result = await _getFeaturedLists(page);

    switch (result) {
      case Success(:final data):
        _totalPages = data.totalPages;
        return data.lists;
      case Failure(:final error):
        throw Exception(error.message);
    }
  }

  @override
  Future<void> close() {
    pagingController.dispose();
    return super.close();
  }
}
