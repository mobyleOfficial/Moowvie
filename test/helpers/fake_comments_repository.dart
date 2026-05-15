import 'package:comments_domain/models/comment_response.dart';
import 'package:comments_domain/repositories/comments_repository.dart';
import 'package:core/core.dart';

/// Hand-rolled fake of [CommentsRepository] for use in unit and widget tests.
class FakeCommentsRepository implements CommentsRepository {
  Result<CommentResponse> getCommentsResult = const Success(
    CommentResponse(comments: [], totalCount: 0, hasMore: false),
  );

  @override
  Future<Result<CommentResponse>> getComments({
    required String contentId,
    required int page,
    int pageSize = 10,
  }) async {
    return getCommentsResult;
  }
}
