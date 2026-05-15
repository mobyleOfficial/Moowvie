import 'package:core/core.dart';
import 'package:comments_domain/models/comment_response.dart';

abstract interface class CommentsRepository {
  Future<Result<CommentResponse>> getComments({
    required String contentId,
    required int page,
    int pageSize = 10,
  });
}
