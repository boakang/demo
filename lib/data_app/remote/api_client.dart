import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/validate_project_request.dart';
import '../model/login_request.dart';
import '../model/login_response.dart';

class ApiClient {
  static const String baseUrl = 'http://10.0.2.2:5064';

  /// Simple JSON GET helper used by feature ApiClients.
  Future<Map<String, dynamic>> getJson(String url) async {
    final response = await http.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final decoded = jsonDecode(response.body);
      return decoded is Map<String, dynamic>
          ? decoded
          : <String, dynamic>{'data': decoded};
    }

    throw Exception('Request failed: ${response.statusCode}');
  }

  /// Simple JSON POST helper used by feature ApiClients.
  Future<Map<String, dynamic>> postJson(
    String url, {
    required Map<String, dynamic> body,
  }) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final decoded = jsonDecode(response.body);
      return decoded is Map<String, dynamic>
          ? decoded
          : <String, dynamic>{'data': decoded};
    }

    throw Exception('Request failed: ${response.statusCode}');
  }

  Future<bool> validateProject(ValidateProjectRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/user/validate-project'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['success'] == true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<LoginResponse?> login(LoginRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/user/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true && data['data'] != null) {
          return LoginResponse.fromJson(data['data']);
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
