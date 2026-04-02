import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_user_record/new_user_record_state.dart';

class NewUserRecordCubit extends Cubit<NewUserRecordState> {
  NewUserRecordCubit() : super(const NewUserRecordLoading());
}
