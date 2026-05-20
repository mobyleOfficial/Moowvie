import 'package:auth_domain/models/oauth_provider.dart';
import 'package:auth_domain/models/oauth_result.dart';

class OAuthResultModel {
  final String provider;
  final String providerToken;

  const OAuthResultModel({
    required this.provider,
    required this.providerToken,
  });

  factory OAuthResultModel.fromJson(Map<String, dynamic> json) =>
      OAuthResultModel(
        provider: json['provider'] as String,
        providerToken: json['provider_token'] as String,
      );

  Map<String, dynamic> toJson() => {
        'provider': provider,
        'provider_token': providerToken,
      };

  OAuthResult toDomain() => OAuthResult(
        provider: provider == 'google'
            ? OAuthProvider.google
            : OAuthProvider.facebook,
        providerToken: providerToken,
      );

  factory OAuthResultModel.fromDomain(OAuthResult result) =>
      OAuthResultModel(
        provider: result.provider == OAuthProvider.google
            ? 'google'
            : 'facebook',
        providerToken: result.providerToken,
      );
}
