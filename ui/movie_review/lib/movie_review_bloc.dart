import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_review/movie_review_state.dart';

class MovieReviewCubit extends Cubit<MovieReviewState> {
  MovieReviewCubit() : super(const MovieReviewLoading()) {
    _load();
  }

  void _load() => emit(const MovieReviewReady());

  void updateRating(double rating) {
    final currentState = state;
    if (currentState is MovieReviewReady) {
      emit(currentState.copyWith(rating: rating));
    }
  }

  void toggleFavorite() {
    final currentState = state;
    if (currentState is MovieReviewReady) {
      emit(currentState.copyWith(isFavorite: !currentState.isFavorite));
    }
  }

  void toggleRewatch() {
    final currentState = state;
    if (currentState is MovieReviewReady) {
      emit(currentState.copyWith(isRewatch: !currentState.isRewatch));
    }
  }

  void toggleTag(String tag) {
    final currentState = state;
    if (currentState is MovieReviewReady) {
      final updatedTags = Set<String>.from(currentState.selectedTags);
      if (updatedTags.contains(tag)) {
        updatedTags.remove(tag);
      } else {
        updatedTags.add(tag);
      }
      emit(currentState.copyWith(selectedTags: updatedTags));
    }
  }
}
