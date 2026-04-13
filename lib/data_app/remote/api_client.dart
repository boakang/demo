import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiClient {
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
}
