import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:auth/auth.dart';
import 'package:auth_ui/login_cubit.dart';
import 'package:auth_ui/login_state.dart';
import 'package:auth_ui/login_screen.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final AuthCubit _authCubit = AuthCubit(
    checkAuthStatusUseCase: GetIt.I<CheckAuthStatusUseCase>(),
    initiateOAuthUseCase: GetIt.I<InitiateOAuthUseCase>(),
    completeOAuthUseCase: GetIt.I<CompleteOAuthUseCase>(),
    clearTokenUseCase: GetIt.I<ClearTokenUseCase>(),
  );

  @override
  void initState() {
    super.initState();
    _authCubit.checkAuthStatus();
  }

  @override
  void dispose() {
    _authCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider<AuthCubit>.value(
        value: _authCubit,
        child: BlocConsumer<AuthCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginAuthenticated) {
              // context.router.replaceNamed('/');
            }
          },
          builder: (context, state) => LoginScreen(state: state),
        ),
      );
}
