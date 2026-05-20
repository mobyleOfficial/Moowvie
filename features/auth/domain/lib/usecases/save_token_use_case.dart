import 'package:core/core.dart';
import 'package:auth_domain/models/auth_token.dart';
import 'package:auth_domain/repositories/auth_repository.dart';

class SaveTokenUseCase extends UseCase<AuthToken, Result<void>> {
  final AuthRepository _repository;

  SaveTokenUseCase(this._repository);

  @override
  Future<Result<void>> call([AuthToken? params]) async {
    if (params == null) {
      return const Failure(AppError.unknown);
    }
    return _repository.saveToken(params);
  }
}
