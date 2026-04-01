import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movies_list/movies_list_router.dart';
import 'package:reviews/reviews_router.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.tabBar(
      routes: const [
        MoviesListRoute(),
        ReviewsRoute(),
      ],
      builder: (context, child, tabController) {
        return Column(
          children: [
            TabBar(
              controller: tabController,
              tabs: const [
                Tab(text: 'Movies'),
                Tab(text: 'Reviews'),
              ],
            ),
            Expanded(child: child),
          ],
        );
      },
    );
  }
}