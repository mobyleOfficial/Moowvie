import 'package:auth_domain/models/oauth_provider.dart';

class OAuthResult {
  final OAuthProvider provider;
  final String providerToken;

  const OAuthResult({
    required this.provider,
    required this.providerToken,
  });
}
