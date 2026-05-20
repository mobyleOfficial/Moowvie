import 'package:core/core.dart';
import 'package:auth_domain/repositories/auth_repository.dart';

class IsUserAuthenticatedUseCase extends UseCase<void, Result<bool>> {
  final AuthRepository _repository;

  IsUserAuthenticatedUseCase(this._repository);

  @override
  Future<Result<bool>> call([void params]) async =>
      _repository.isUserAuthenticated();
}
