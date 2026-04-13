import 'package:equatable/equatable.dart';

class LoginRequestModel extends Equatable {
  const LoginRequestModel({
    required this.projectCode,
    required this.userName,
    required this.password,
  });

  final String projectCode;
  final String userName;
  final String password;

  LoginRequestModel copyWith({
    String? projectCode,
    String? userName,
    String? password,
  }) {
    return LoginRequestModel(
      projectCode: projectCode ?? this.projectCode,
      userName: userName ?? this.userName,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [projectCode, userName, password];
}

