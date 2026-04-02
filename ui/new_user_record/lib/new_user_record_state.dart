sealed class NewUserRecordState {
  const NewUserRecordState();
}

class NewUserRecordLoading extends NewUserRecordState {
  const NewUserRecordLoading();
}

class NewUserRecordSuccess extends NewUserRecordState {
  const NewUserRecordSuccess();
}

class NewUserRecordError extends NewUserRecordState {
  final String message;

  const NewUserRecordError(this.message);
}
