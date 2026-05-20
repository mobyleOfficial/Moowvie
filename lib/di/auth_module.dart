import 'package:injectable/injectable.dart';
import 'package:core/core.dart';
import 'package:auth/auth.dart';

@module
abstract class AuthModule {
  @lazySingleton
  SecureTokenStorage secureTokenStorage() => SecureTokenStorage();

  @lazySingleton
  OAuthRemoteDataSource oauthRemoteDataSource(
    @Named('backend') HttpClient httpClient,
  ) =>
      OAuthRemoteDataSourceImpl(httpClient);

  @lazySingleton
  AuthLocalDataSource authLocalDataSource(
    SecureTokenStorage secureStorage,
  ) =>
      AuthLocalDataSourceImpl(secureStorage);

  @lazySingleton
  AuthRepository authRepository(
    OAuthRemoteDataSource remoteDataSource,
    AuthLocalDataSource localDataSource,
  ) =>
      AuthRepositoryImpl(remoteDataSource, localDataSource);

  @injectable
  CheckAuthStatusUseCase checkAuthStatusUseCase(
    AuthRepository repository,
  ) =>
      CheckAuthStatusUseCase(repository);

  @injectable
  InitiateOAuthUseCase initiateOAuthUseCase(
    AuthRepository repository,
  ) =>
      InitiateOAuthUseCase(repository);

  @injectable
  CompleteOAuthUseCase completeOAuthUseCase(
    AuthRepository repository,
  ) =>
      CompleteOAuthUseCase(repository);

  @injectable
  SaveTokenUseCase saveTokenUseCase(
    AuthRepository repository,
  ) =>
      SaveTokenUseCase(repository);

  @injectable
  ClearTokenUseCase clearTokenUseCase(
    AuthRepository repository,
  ) =>
      ClearTokenUseCase(repository);
}
