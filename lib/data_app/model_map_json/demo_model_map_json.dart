import 'package:mobile_app/data_app/model/demo_model.dart';

class LoginResultModelMapJson {
  const LoginResultModelMapJson._();

  static LoginResultModel fromJson(dynamic json) {
    final map = _asMap(json) ?? <String, dynamic>{};
    final data = _asMap(map['data']) ?? map;

    return LoginResultModel(
      success: _toBool(map['success'] ?? map['isSuccess'] ?? data['success']),
      message: _toString(map['message'] ?? map['msg'] ?? data['message']),
      userId: _toNullableString(
        map['userId'] ?? map['user_id'] ?? data['userId'] ?? data['user_id'],
      ),
      projectCode: _toNullableString(
        map['projectCode'] ?? map['project_code'] ?? data['projectCode'],
      ),
      userName: _toNullableString(
        map['userName'] ?? map['username'] ?? data['userName'] ?? data['username'],
      ),
      token: _toNullableString(map['token'] ?? map['accessToken'] ?? data['token']),
      rawJson: map,
    );
  }

  static Map<String, dynamic> toJson(LoginResultModel model) {
    return <String, dynamic>{
      'success': model.success,
      'message': model.message,
      'userId': model.userId,
      'projectCode': model.projectCode,
      'userName': model.userName,
      'token': model.token,
    };
  }

  static Map<String, dynamic>? _asMap(dynamic value) {
    if (value is Map<String, dynamic>) {
      return value;
    }
    if (value is Map) {
      return value.map<String, dynamic>((key, dynamic item) {
        return MapEntry(key.toString(), item);
      });
    }
    return null;
  }

  static bool _toBool(dynamic value) {
    if (value is bool) {
      return value;
    }
    if (value is num) {
      return value != 0;
    }
    if (value is String) {
      return value.toLowerCase() == 'true' || value == '1';
    }
    return false;
  }

  static String _toString(dynamic value) {
    if (value == null) {
      return '';
    }
    return value.toString();
  }

  static String? _toNullableString(dynamic value) {
    if (value == null) {
      return null;
    }
    final text = value.toString();
    return text.isEmpty ? null : text;
  }
}

