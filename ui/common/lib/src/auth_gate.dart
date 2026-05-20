import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:core/core.dart';
import 'package:auth/auth.dart';

class AuthGate {
  static PageRouteInfo? _loginRoute;

  /// Register the login route at app startup.
  /// Must be called before any [check] calls.
  static void configure({required PageRouteInfo loginRoute}) {
    _loginRoute = loginRoute;
  }

  /// Returns true if user is authenticated (or just logged in via modal).
  /// Returns false if user dismissed the login without logging in.
  static Future<bool> check(BuildContext context) async {
    final result = await GetIt.I<IsUserAuthenticatedUseCase>()();

    if (result is Success<bool> && result.data) {
      return true;
    }

    assert(
      _loginRoute != null,
      'AuthGate.configure() must be called before AuthGate.check()',
    );

    final loginResult = await context.router.root.push<bool>(_loginRoute!);

    return loginResult == true;
  }
}
