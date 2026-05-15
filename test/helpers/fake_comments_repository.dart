import 'package:comments_domain/models/comment_listing.dart';
import 'package:comments_domain/repositories/comments_repository.dart';
import 'package:core/core.dart';

/// Hand-rolled fake of [CommentsRepository] for use in unit and widget tests.
class FakeCommentsRepository implements CommentsRepository {
  Result<CommentListing> getCommentsResult = const Success(
    CommentListing(comments: [], totalCount: 0, hasMore: false),
  );

  @override
  Future<Result<CommentListing>> getComments({
    required String contentId,
    required int page,
    int pageSize = 10,
  }) async {
    return getCommentsResult;
  }
}
