import 'package:flutter_test/flutter_test.dart';
import 'package:core/core.dart';
import 'package:comments/comments.dart';

class MockCommentsRepository implements CommentsRepository {
  CommentResponse? mockResponse;
  AppError? mockError;

  @override
  Future<Result<CommentResponse>> getComments({
    required String contentId,
    required int page,
    int pageSize = 10,
  }) async {
    if (mockError != null) {
      return Failure(mockError!);
    }
    if (mockResponse != null) {
      return Success(mockResponse!);
    }
    return Failure(AppError.unknown);
  }
}

void main() {
  group('GetCommentsUseCase', () {
    late GetCommentsUseCase getCommentsUseCase;
    late MockCommentsRepository mockRepository;

    setUp(() {
      mockRepository = MockCommentsRepository();
      getCommentsUseCase = GetCommentsUseCase(mockRepository);
    });

    test('should call getComments on repository with correct parameters', () async {
      const contentId = 'review-001';
      const page = 0;
      const pageSize = 10;

      final mockComments = [
        Comment(
          id: 'comment-1',
          authorName: 'John Doe',
          authorAvatar: 'https://example.com/avatar.jpg',
          content: 'Great review!',
          createdAt: DateTime(2026, 5, 15),
          rating: 4.5,
        ),
      ];

      final expectedResponse = CommentResponse(
        comments: mockComments,
        totalCount: 1,
        hasMore: false,
      );

      mockRepository.mockResponse = expectedResponse;

      final result = await getCommentsUseCase(
        GetCommentsParams(
          contentId: contentId,
          page: page,
          pageSize: pageSize,
        ),
      );

      expect(result, isA<Success>());
      final successResult = result as Success;
      expect(successResult.data.comments.length, equals(1));
      expect(successResult.data.totalCount, equals(1));
      expect(successResult.data.hasMore, equals(false));
    });

    test('should return failure when repository fails', () async {
      const contentId = 'review-001';

      mockRepository.mockError = AppError.network;

      final result = await getCommentsUseCase(
        GetCommentsParams(contentId: contentId),
      );

      expect(result, isA<Failure>());
      final failureResult = result as Failure;
      expect(failureResult.error, equals(AppError.network));
    });

    test('should use default parameters when none provided', () async {
      const contentId = 'list-001';

      final mockComments = <Comment>[];

      final expectedResponse = CommentResponse(
        comments: mockComments,
        totalCount: 0,
        hasMore: false,
      );

      mockRepository.mockResponse = expectedResponse;

      final result = await getCommentsUseCase(
        GetCommentsParams(contentId: contentId),
      );

      expect(result, isA<Success>());
      final successResult = result as Success;
      expect(successResult.data.comments.isEmpty, true);
    });
  });
}
