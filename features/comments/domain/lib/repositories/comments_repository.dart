import 'package:core/core.dart';
import 'package:comments_domain/models/comment_listing.dart';

abstract interface class CommentsRepository {
  Future<Result<CommentListing>> getComments({
    required String contentId,
    required int page,
    int pageSize = 10,
  });
}
