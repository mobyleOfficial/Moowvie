import 'package:auto_route/auto_route.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/movies.dart';

import 'package:reviews/reviews_list/reviews_page.dart';

part 'reviews_router.gr.dart';

@AutoRouterConfig(generateForDir: ['lib'])
class ReviewsRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: ReviewsRoute.page),
      ];
}
