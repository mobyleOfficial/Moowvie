import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:common/common.dart';
import 'package:auth_ui/login_cubit.dart';
import 'package:auth_ui/login_state.dart';

class LoginScreen extends StatelessWidget {
  final LoginState state;

  const LoginScreen({super.key, required this.state});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: switch (state) {
            LoginLoading() => _buildLoadingState(context),
            LoginAuthenticated() => _buildLoadingState(context),
            LoginUnauthenticated() => _buildLoginForm(context),
            LoginError(:final message) =>
              _buildLoginForm(context, errorMessage: message),
          },
        ),
      );

  Widget _buildLoadingState(BuildContext context) => const Center(
        child: CircularProgressIndicator(),
      );

  Widget _buildLoginForm(
    BuildContext context, {
    String? errorMessage,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(flex: 2),
            Icon(
              Icons.movie_outlined,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
              semanticLabel: null,
            ),
            const SizedBox(height: 24),
            Text(
              AppLocalizations.of(context)!.appTitle,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.loginSubtitle,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
            const Spacer(flex: 2),
            if (errorMessage != null) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  errorMessage,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color:
                            Theme.of(context).colorScheme.onErrorContainer,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
            ],
            SizedBox(
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () =>
                    context.read<LoginCubit>().loginWithGoogle(),
                icon: const Icon(Icons.g_mobiledata, size: 24),
                label: Text(
                  AppLocalizations.of(context)!.continueWithGoogle,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  foregroundColor:
                      Theme.of(context).colorScheme.onPrimaryContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () =>
                    context.read<LoginCubit>().loginWithFacebook(),
                icon: const Icon(Icons.facebook, size: 24),
                label: Text(
                  AppLocalizations.of(context)!.continueWithFacebook,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.secondaryContainer,
                  foregroundColor:
                      Theme.of(context).colorScheme.onSecondaryContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const Spacer(flex: 3),
          ],
        ),
      );
}
