import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/movies.dart';

import 'package:search/featured_lists/featured_lists_bloc.dart';
import 'package:search/featured_lists/featured_lists_screen.dart';

@RoutePage()
class FeaturedListsPage extends StatefulWidget {
  const FeaturedListsPage({super.key});

  @override
  State<FeaturedListsPage> createState() => _FeaturedListsPageState();
}

class _FeaturedListsPageState extends State<FeaturedListsPage> {
  late final FeaturedListsCubit _cubit = FeaturedListsCubit(
    GetIt.I<GetFeaturedLists>(),
  );

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FeaturedListsScreen(cubit: _cubit);
}
