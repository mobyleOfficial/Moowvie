import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:reviews/reviews_list/reviews_screen.dart';

@RoutePage()
class ReviewsPage extends StatelessWidget {
  const ReviewsPage({super.key});

  @override
  Widget build(BuildContext context) => const ReviewsScreen();
}
