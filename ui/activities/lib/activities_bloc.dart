import 'package:activities/activities_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivitiesCubit extends Cubit<ActivitiesState> {
  ActivitiesCubit() : super(const ActivitiesLoading());
}
