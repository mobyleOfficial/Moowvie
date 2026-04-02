import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:new_user_record/new_user_record_bloc.dart';
import 'package:new_user_record/new_user_record_screen.dart';

@RoutePage()
class NewUserRecordPage extends StatefulWidget {
  const NewUserRecordPage({super.key});

  @override
  State<NewUserRecordPage> createState() => _NewUserRecordPageState();
}

class _NewUserRecordPageState extends State<NewUserRecordPage> {
  final NewUserRecordCubit _cubit = NewUserRecordCubit();

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NewUserRecordScreen(cubit: _cubit);
  }
}
