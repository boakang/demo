part of 'demo_bloc.dart';

abstract class DemoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ValidateProjectEvent extends DemoEvent {
  final String projectCode;

  ValidateProjectEvent(this.projectCode);

  @override
  List<Object?> get props => [projectCode];
}

class LoginEvent extends DemoEvent {
  final String username;
  final String password;
  final String projectCode;

  LoginEvent({
    required this.username,
    required this.password,
    required this.projectCode,
  });

  @override
  List<Object?> get props => [username, password, projectCode];
}

