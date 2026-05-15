import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_domain/domain.dart';

import '../../../../helpers/fake_movies_repository.dart';

void main() {
  group('UnlikeReview', () {
    test('delegates to repository.unlikeReview and returns its Result',
        () async {
      final fakeRepository = FakeMoviesRepository()
        ..unlikeReviewResult = const Success(null);
      final useCase = UnlikeReview(fakeRepository);

      final result = await useCase('r-1-0');

      expect(fakeRepository.lastUnlikeReviewId, 'r-1-0');
      expect(result, isA<Success<void>>());
    });

    test('propagates failure', () async {
      final fakeRepository = FakeMoviesRepository()
        ..unlikeReviewResult = const Failure(AppError.server);
      final useCase = UnlikeReview(fakeRepository);

      final result = await useCase('r-1-0');

      expect(result, isA<Failure<void>>());
    });
  });
}
