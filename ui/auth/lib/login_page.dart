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
  late final LoginCubit _cubit = LoginCubit(
    loginUseCase: GetIt.I<LoginUseCase>(),
    isUserAuthenticatedUseCase: GetIt.I<IsUserAuthenticatedUseCase>(),
  );

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider<LoginCubit>.value(
        value: _cubit,
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginAuthenticated) {
              context.router.maybePop(true);
            }
          },
          builder: (context, state) => LoginScreen(
            state: state,
            onClose: () => context.router.maybePop(false),
          ),
        ),
      );
}
