import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_user_record/new_user_record_bloc.dart';
import 'package:new_user_record/new_user_record_state.dart';

class NewUserRecordScreen extends StatelessWidget {
  final NewUserRecordCubit cubit;

  const NewUserRecordScreen({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(AppLocalizations.of(context)!.newUserRecordTab),
    ),
    body: BlocProvider.value(
      value: cubit,
      child: BlocBuilder<NewUserRecordCubit, NewUserRecordState>(
        builder: (context, state) => switch (state) {
          NewUserRecordLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
          NewUserRecordSuccess() => Center(
              child: Text(AppLocalizations.of(context)!.newUserRecordTab),
            ),
          NewUserRecordError() => Center(
              child: Text(state.message),
            ),
        },
      ),
    ),
  );
}
