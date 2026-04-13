import 'package:equatable/equatable.dart';

class LoginResultModel extends Equatable {
  const LoginResultModel({
    required this.success,
    required this.message,
    this.userId,
    this.projectCode,
    this.userName,
    this.token,
    this.rawJson = const <String, dynamic>{},
  });

  final bool success;
  final String message;
  final String? userId;
  final String? projectCode;
  final String? userName;
  final String? token;
  final Map<String, dynamic> rawJson;

  LoginResultModel copyWith({
    bool? success,
    String? message,
    String? userId,
    String? projectCode,
    String? userName,
    String? token,
    Map<String, dynamic>? rawJson,
  }) {
    return LoginResultModel(
      success: success ?? this.success,
      message: message ?? this.message,
      userId: userId ?? this.userId,
      projectCode: projectCode ?? this.projectCode,
      userName: userName ?? this.userName,
      token: token ?? this.token,
      rawJson: rawJson ?? this.rawJson,
    );
  }

  @override
  List<Object?> get props => [success, message, userId, projectCode, userName, token];
}

