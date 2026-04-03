sealed class ReviewDetailsState {
  const ReviewDetailsState();
}

class ReviewDetailsLoading extends ReviewDetailsState {
  const ReviewDetailsLoading();
}

class ReviewDetailsSuccess extends ReviewDetailsState {
  const ReviewDetailsSuccess();
}

class ReviewDetailsError extends ReviewDetailsState {
  final String message;
  const ReviewDetailsError(this.message);
}
