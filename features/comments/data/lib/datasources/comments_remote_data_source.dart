import 'package:core/core.dart';
import 'package:comments_data/models/comment_model.dart';

abstract interface class CommentsRemoteDataSource {
  Future<Result<CommentsRemoteResponse>> getComments({
    required String contentId,
    required int page,
    required int pageSize,
  });
}

class CommentsRemoteResponse {
  final List<CommentModel> comments;
  final int totalCount;
  final bool hasMore;

  const CommentsRemoteResponse({
    required this.comments,
    required this.totalCount,
    required this.hasMore,
  });
}
