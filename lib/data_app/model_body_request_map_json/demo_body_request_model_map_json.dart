import 'package:mobile_app/data_app/model_body_request/demo_body_request_model.dart';

class LoginRequestModelMapJson {
  const LoginRequestModelMapJson._();

  static Map<String, dynamic> toJson(LoginRequestModel model) {
    return <String, dynamic>{
      'projectCode': model.projectCode,
      'username': model.userName,
      'password': model.password,
    };
  }

  static LoginRequestModel fromJson(Map<String, dynamic> json) {
    return LoginRequestModel(
      projectCode: _toString(json['projectCode'] ?? json['project_code']),
      userName: _toString(json['userName'] ?? json['username']),
      password: _toString(json['password']),
    );
  }

  static String _toString(dynamic value) {
    if (value == null) {
      return '';
    }
    return value.toString();
  }
}

