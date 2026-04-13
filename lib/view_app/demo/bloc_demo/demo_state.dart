part of 'demo_bloc.dart';

abstract class DemoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DemoInitialState extends DemoState {}

class ValidatingProjectState extends DemoState {}

class ProjectValidatedState extends DemoState {
  final String projectCode;

  ProjectValidatedState(this.projectCode);

  @override
  List<Object?> get props => [projectCode];
}

class ProjectValidationFailedState extends DemoState {
  final String error;

  ProjectValidationFailedState(this.error);

  @override
  List<Object?> get props => [error];
}

class LoggingInState extends DemoState {}

class LoginSuccessState extends DemoState {
  final String userId;
  final String userName;
  final String token;
  final String projectCode;

  LoginSuccessState({
    required this.userId,
    required this.userName,
    required this.token,
    required this.projectCode,
  });

  @override
  List<Object?> get props => [userId, userName, token, projectCode];
}

class LoginFailedState extends DemoState {
  final String error;

  LoginFailedState(this.error);

  @override
  List<Object?> get props => [error];
}

