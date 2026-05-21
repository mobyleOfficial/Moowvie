import 'package:core/core.dart';
import 'package:auth_domain/repositories/auth_repository.dart';

class IsUserAuthenticated extends UseCase<void, Result<bool>> {
  final AuthRepository _repository;

  IsUserAuthenticated(this._repository);

  @override
  Future<Result<bool>> call([void params]) async =>
      _repository.isUserAuthenticated();
}
