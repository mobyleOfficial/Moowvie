import 'package:comments/comments.dart';
import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:movies_domain/domain.dart';
import 'package:reviews/review_details/review_details_bloc.dart';
import 'package:reviews/review_details/review_details_screen.dart';

import '../../../helpers/fake_comments_repository.dart';
import '../../../helpers/fake_movies_repository.dart';

class _FakeShareService implements ShareService {
  MovieReview? lastShared;

  @override
  Future<void> shareReview(MovieReview review) async {
    lastShared = review;
  }
}

const _sampleReview = MovieReview(
  id: 'r-1-0',
  movieId: 1,
  title: 'Sample Movie',
  date: 'Jan 1, 2024',
  rating: 4.0,
  author: 'Author',
  authorId: 'u-1',
  content: 'Sample body text.',
  likeCount: 3,
);

void main() {
  setUp(() {
    final shareService = _FakeShareService();
    final commentsRepository = FakeCommentsRepository();
    final getCommentsUseCase = GetComments(commentsRepository);
    final getIt = GetIt.instance;

    // Clear existing registrations
    if (getIt.isRegistered<ShareService>()) {
      getIt.unregister<ShareService>();
    }
    if (getIt.isRegistered<GetComments>()) {
      getIt.unregister<GetComments>();
    }

    // Register dependencies
    getIt.registerLazySingleton<ShareService>(() => shareService);
    getIt.registerLazySingleton<GetComments>(() => getCommentsUseCase);
  });

  tearDown(() async {
    await GetIt.instance.reset();
  });

  testWidgets('renders loading then success after primary fetch',
      (tester) async {
    final repository = FakeMoviesRepository()
      ..reviewDetailsResult = const Success(_sampleReview)
      ..movieReviewsResult = const Success(
        MovieReviewListing(totalPages: 1, totalResults: 0, reviews: []),
      );

    final cubit = ReviewDetailsCubit(
      reviewId: 'r-1-0',
      getReviewDetails: GetReviewDetails(repository),
      getMovieReviews: GetMovieReviews(repository),
      likeReview: LikeReview(repository),
      unlikeReview: UnlikeReview(repository),
    );

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: ReviewDetailsScreen(cubit: cubit),
      ),
    );

    // Let all pending microtasks (primary + secondary fetches) settle.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    await tester.pump();

    expect(find.text('Sample body text.'), findsOneWidget);

    await cubit.close();
  });
}
