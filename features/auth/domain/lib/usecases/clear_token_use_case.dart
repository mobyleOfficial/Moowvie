import 'package:core/core.dart';
import 'package:auth_domain/repositories/auth_repository.dart';

class ClearTokenUseCase extends UseCase<void, Result<void>> {
  final AuthRepository _repository;

  ClearTokenUseCase(this._repository);

  @override
  Future<Result<void>> call([void params]) async =>
      _repository.clearToken();
}
