import 'package:mobile_app/data_app/model/demo_model.dart';
import 'package:mobile_app/data_app/model_body_request/demo_body_request_model.dart';
import 'package:mobile_app/data_app/remote/demo_api_client.dart';

class AuthRepository {
  final LoginApiClient _apiClient;

  AuthRepository({required LoginApiClient apiClient}) : _apiClient = apiClient;

  Future<LoginResultModel> validateProject(String projectCode) async {
    return _apiClient.validateProjectCode(projectCode);
  }

  Future<LoginResultModel> login(
    String username,
    String password,
    String projectCode,
  ) async {
    // Adapter: map simple request -> specific LoginRequestModel used by demo_api_client
    final body = LoginRequestModel(
      projectCode: projectCode,
      userName: username,
      password: password,
    );
    return _apiClient.authenticateToken(body);
  }
}
