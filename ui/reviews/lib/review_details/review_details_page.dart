import 'package:auto_route/auto_route.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:reviews/review_details/review_details_bloc.dart';
import 'package:reviews/review_details/review_details_screen.dart';

@RoutePage()
class ReviewDetailsPage extends StatefulWidget {
  final String movieTitle;
  final String reviewDate;
  final double rating;
  final int posterColorIndex;

  const ReviewDetailsPage({
    super.key,
    required this.movieTitle,
    required this.reviewDate,
    required this.rating,
    required this.posterColorIndex,
  });

  @override
  State<ReviewDetailsPage> createState() => _ReviewDetailsPageState();
}

class _ReviewDetailsPageState extends State<ReviewDetailsPage> {
  late final ReviewDetailsCubit _cubit = ReviewDetailsCubit();

  // Captured once at mount — no InheritedWidget dependency created.
  AppBarController? _appBarController;
  int _tabIndex = 0;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;
    _initialized = true;
    _appBarController = AppBarControllerScope.find(context);
    _tabIndex = TabIndexScope.find(context) ?? 0;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _appBarController?.setTitle(
          tabIndex: _tabIndex,
          title: widget.movieTitle,
        );
      }
    });
  }

  @override
  void dispose() {
    final controller = _appBarController;
    final tabIndex = _tabIndex;
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => controller?.setTitle(tabIndex: tabIndex, title: null),
    );
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ReviewDetailsScreen(
        cubit: _cubit,
        movieTitle: widget.movieTitle,
        reviewDate: widget.reviewDate,
        rating: widget.rating,
        posterColorIndex: widget.posterColorIndex,
      );
}
