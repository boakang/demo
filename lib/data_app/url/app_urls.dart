class AppUrls {
  const AppUrls._();

  static const String baseUrl = 'http://10.0.2.2:5064/api/user';
  static const String getProjectCodeUrl = '$baseUrl/validate-project';
  static const String authenticateTokenUrl = '$baseUrl/login';
}

