import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:core/core.dart';
import 'package:auth/auth.dart';
import 'package:common/src/moovie_bottom_sheet.dart';

class AuthGate {
  static WidgetBuilder? _loginModalBuilder;

  /// Register the login modal builder at app startup.
  /// Must be called before any [check] calls.
  static void configure({required WidgetBuilder loginModalBuilder}) {
    _loginModalBuilder = loginModalBuilder;
  }

  /// Returns true if user is authenticated (or just logged in via modal).
  /// Returns false if user dismissed the modal without logging in.
  static Future<bool> check(BuildContext context) async {
    final result = await GetIt.I<IsUserAuthenticatedUseCase>()();

    if (result is Success<bool> && result.data) {
      return true;
    }

    assert(
      _loginModalBuilder != null,
      'AuthGate.configure() must be called before AuthGate.check()',
    );

    final loginResult = await MoovieBottomSheet.show<bool>(
      context: context,
      builder: _loginModalBuilder!,
    );

    return loginResult == true;
  }
}
