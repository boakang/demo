import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  LocalStorageService._internal();

  static final LocalStorageService instance = LocalStorageService._internal();

  static const String _authTokenKey = 'auth_token';

  Future<SharedPreferences> get _prefs async => SharedPreferences.getInstance();

  Future<String?> getAuthToken() async {
    final prefs = await _prefs;
    return prefs.getString(_authTokenKey);
  }

  Future<void> setAuthToken(String token) async {
    final prefs = await _prefs;
    await prefs.setString(_authTokenKey, token);
  }

  Future<void> clearAuthToken() async {
    final prefs = await _prefs;
    await prefs.remove(_authTokenKey);
  }
}

