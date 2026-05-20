import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureTokenStorage {
  static const String _tokenKey = 'auth_token';
  final FlutterSecureStorage _storage;

  SecureTokenStorage({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  Future<void> saveToken(Map<String, dynamic> tokenJson) async {
    final encoded = jsonEncode(tokenJson);
    await _storage.write(key: _tokenKey, value: encoded);
  }

  Future<Map<String, dynamic>?> getToken() async {
    final encoded = await _storage.read(key: _tokenKey);
    if (encoded == null) return null;
    return jsonDecode(encoded) as Map<String, dynamic>;
  }

  Future<void> clearToken() async {
    await _storage.delete(key: _tokenKey);
  }
}
