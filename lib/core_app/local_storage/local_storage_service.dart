class LocalStorageService {
  LocalStorageService._internal();

  static final LocalStorageService instance = LocalStorageService._internal();

  final Map<String, String> _memoryStorage = <String, String>{
    _authTokenKey: 'mock-demo-token',
  };

  static const String _authTokenKey = 'auth_token';

  Future<String?> getAuthToken() async {
    return _memoryStorage[_authTokenKey];
  }

  Future<void> setAuthToken(String token) async {
    _memoryStorage[_authTokenKey] = token;
  }

  Future<void> clearAuthToken() async {
    _memoryStorage.remove(_authTokenKey);
  }
}

