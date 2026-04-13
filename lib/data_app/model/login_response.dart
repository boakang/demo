class LoginResponse {
  final String userId;
  final String userName;
  final String token;

  LoginResponse({
    required this.userId,
    required this.userName,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
      token: json['token'] ?? '',
    );
  }
}
