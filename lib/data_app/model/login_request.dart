class LoginRequest {
  final String username;
  final String password;
  final String projectCode;

  LoginRequest({
    required this.username,
    required this.password,
    required this.projectCode,
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
    'projectCode': projectCode,
  };
}
