import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:comments/comments.dart';
import 'package:comments_ui/comments_state.dart';
import 'package:get_it/get_it.dart';

class CommentsCubit extends Cubit<CommentsState> {
  final GetComments _getCommentsUseCase;
  late String _contentId;
  int _currentPage = 0;
  int _pageSize = 10;
  List<Comment> _allComments = [];
  int _totalCount = 0;
  bool _hasMore = false;

  CommentsCubit({GetComments? getCommentsUseCase})
      : _getCommentsUseCase =
            getCommentsUseCase ?? GetIt.I<GetComments>(),
        super(const CommentsLoading());

  Future<void> loadComments(String contentId) async {
    _contentId = contentId;
    _currentPage = 0;
    _allComments = [];
    _totalCount = 0;
    _hasMore = false;

    emit(const CommentsLoading());
    await _fetchComments(0);
  }

  Future<void> loadMoreComments() async {
    final currentState = state;
    if (currentState is! CommentsSuccess || !currentState.hasMore) {
      return;
    }

    await _fetchComments(_currentPage + 1);
  }

  Future<void> _fetchComments(int page) async {
    final result = await _getCommentsUseCase(
      GetCommentsParams(
        contentId: _contentId,
        page: page,
        pageSize: _pageSize,
      ),
    );

    switch (result) {
      case Success(:final data):
        _currentPage = page;
        _allComments = [..._allComments, ...data.comments];
        _totalCount = data.totalCount;
        _hasMore = data.hasMore;

        emit(
          CommentsSuccess(
            comments: _allComments,
            totalCount: _totalCount,
            hasMore: _hasMore,
            currentPage: _currentPage,
          ),
        );
      case Failure(:final error):
        emit(CommentsError(error.message ?? 'Failed to load comments'));
    }
  }
}
