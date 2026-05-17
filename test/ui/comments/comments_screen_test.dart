import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core/core.dart';
import 'package:comments/comments.dart';
import 'package:comments_ui/comments.dart';

class MockGetCommentsUseCase implements GetCommentsUseCase {
  Future<Result<CommentListing>>? mockResult;

  @override
  Future<Result<CommentListing>> call([GetCommentsParams? params]) async {
    if (mockResult != null) {
      return mockResult!;
    }
    return Failure(AppError.unknown);
  }
}

void main() {
  group('CommentsScreen', () {
    test('CommentsScreen instantiates correctly', () {
      const screen = CommentsScreen(contentId: 'review-001');
      expect(screen, isA<CommentsScreen>());
      expect(screen.contentId, equals('review-001'));
    });

    test('CommentsScreen is a StatefulWidget', () {
      const screen = CommentsScreen(contentId: 'review-001');
      expect(screen, isA<StatefulWidget>());
    });

    test('CommentsScreen has proper widget properties', () {
      const contentId = 'test-content-id';
      const screen = CommentsScreen(contentId: contentId);
      expect(screen.contentId, equals(contentId));
    });
  });
}
