import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core_app/local_storage/local_storage_service.dart';
import '../../../data_app/repository/auth_repository.dart';

part 'demo_event.dart';
part 'demo_state.dart';

class DemoBloc extends Bloc<DemoEvent, DemoState> {
  final AuthRepository authRepository;
  String? currentProjectCode;

  DemoBloc({required this.authRepository}) : super(DemoInitialState()) {
    on<ValidateProjectEvent>(_onValidateProject);
    on<LoginEvent>(_onLogin);
  }

  Future<void> _onValidateProject(
    ValidateProjectEvent event,
    Emitter<DemoState> emit,
  ) async {
    emit(ValidatingProjectState());
    
    try {
      final result = await authRepository.validateProject(event.projectCode);

      if (result.success) {
        final code = result.projectCode ?? event.projectCode;
        currentProjectCode = code;
        emit(ProjectValidatedState(code));
      } else {
        emit(ProjectValidationFailedState(result.message));
      }
    } catch (e) {
      emit(ProjectValidationFailedState('Error: ${e.toString()}'));
    }
  }

  Future<void> _onLogin(
    LoginEvent event,
    Emitter<DemoState> emit,
  ) async {
    emit(LoggingInState());

    try {
      final result = await authRepository.login(
        event.username,
        event.password,
        event.projectCode,
      );

      if (result.success) {
        await LocalStorageService.instance.setAuthToken(result.token ?? '');
        emit(
          LoginSuccessState(
            userId: result.userId ?? '0',
            userName: result.userName ?? '',
            token: result.token ?? '',
            projectCode: result.projectCode ?? event.projectCode,
          ),
        );
      } else {
        emit(LoginFailedState(result.message));
      }
    } catch (e) {
      emit(LoginFailedState('Error: ${e.toString()}'));
    }
  }
}

