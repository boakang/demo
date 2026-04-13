import 'package:mobile_app/data_app/model/demo_model.dart';
import 'package:mobile_app/data_app/model_body_request/demo_body_request_model.dart';
import 'package:mobile_app/data_app/remote/demo_api_client.dart';

abstract class LoginRepository {
  Future<LoginResultModel> validateProjectCode(String projectCode);
  Future<LoginResultModel> authenticateToken(LoginRequestModel body);
}

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl(this._apiClient);

  final LoginApiClient _apiClient;

  @override
  Future<LoginResultModel> validateProjectCode(String projectCode) {
    return _apiClient.validateProjectCode(projectCode);
  }

  @override
  Future<LoginResultModel> authenticateToken(LoginRequestModel body) {
    return _apiClient.authenticateToken(body);
  }
}

