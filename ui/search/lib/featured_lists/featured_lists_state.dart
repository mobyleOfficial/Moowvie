sealed class FeaturedListsState {
  const FeaturedListsState();
}

class FeaturedListsLoading extends FeaturedListsState {
  const FeaturedListsLoading();
}

class FeaturedListsSuccess extends FeaturedListsState {
  const FeaturedListsSuccess();
}

class FeaturedListsError extends FeaturedListsState {
  final String message;

  const FeaturedListsError(this.message);
}
