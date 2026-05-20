import 'package:core/core.dart';
import 'package:auth_domain/models/auth_status.dart';
import 'package:auth_domain/repositories/auth_repository.dart';

class CheckAuthStatusUseCase extends UseCase<void, Result<AuthStatus>> {
  final AuthRepository _repository;

  CheckAuthStatusUseCase(this._repository);

  @override
  Future<Result<AuthStatus>> call([void params]) async =>
      _repository.checkAuthStatus();
}
