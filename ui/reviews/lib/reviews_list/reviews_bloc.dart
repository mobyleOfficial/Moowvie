import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reviews/reviews_list/reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  ReviewsCubit() : super(const ReviewsLoading()) {
    _load();
  }

  void _load() => emit(const ReviewsSuccess());
}
