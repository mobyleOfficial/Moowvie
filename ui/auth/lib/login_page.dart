import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:auth/auth.dart';
import 'package:auth_ui/login_cubit.dart';
import 'package:auth_ui/login_state.dart';
import 'package:auth_ui/login_screen.dart';

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
              Navigator.of(context).pop(true);
            }
          },
          builder: (context, state) => SizedBox(
            height: MediaQuery.of(context).size.height * 0.85,
            child: LoginScreen(state: state),
          ),
        ),
      );
}
