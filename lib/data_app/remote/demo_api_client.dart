import 'package:mobile_app/data_app/model/demo_model.dart';
import 'package:mobile_app/data_app/model_body_request/demo_body_request_model.dart';
import 'package:mobile_app/data_app/model_body_request_map_json/demo_body_request_model_map_json.dart';
import 'package:mobile_app/data_app/model_map_json/demo_model_map_json.dart';
import 'package:mobile_app/data_app/remote/api_client.dart';
import 'package:mobile_app/data_app/url/app_urls.dart';

class LoginApiClient {
  LoginApiClient(this._apiClient);

  final ApiClient _apiClient;

  Future<LoginResultModel> validateProjectCode(String projectCode) async {
    final response = await _apiClient.postJson(
      AppUrls.getProjectCodeUrl,
      body: <String, dynamic>{'projectCode': projectCode},
    );
    final model = LoginResultModelMapJson.fromJson(response);
    return model.copyWith(projectCode: projectCode);
  }

  Future<LoginResultModel> authenticateToken(LoginRequestModel body) async {
    final response = await _apiClient.postJson(
      AppUrls.authenticateTokenUrl,
      body: LoginRequestModelMapJson.toJson(body),
    );
    return LoginResultModelMapJson.fromJson(response);
  }
}

