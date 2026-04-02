import 'package:activities/activities_bloc.dart';
import 'package:activities/activities_state.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivitiesScreen extends StatelessWidget {
  final ActivitiesCubit cubit;

  const ActivitiesScreen({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<ActivitiesCubit, ActivitiesState>(
        builder: (context, state) {
          return switch (state) {
            ActivitiesLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            ActivitiesSuccess() => Center(
                child: Text(AppLocalizations.of(context)!.activitiesTab),
              ),
            ActivitiesError() => Center(
                child: Text(state.message),
              ),
          };
        },
      ),
    );
  }
}
