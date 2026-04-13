import 'package:mobile_app/core_app/config/app_config.dart';
import 'package:mobile_app/core_app/local_storage/local_storage_service.dart';

class AuthHeaderService {
  AuthHeaderService({LocalStorageService? localStorageService})
      : _localStorageService = localStorageService ?? LocalStorageService.instance;

  final LocalStorageService _localStorageService;

  /// Giả lập bước lấy token bất đồng bộ trước khi gọi API.
  Future<Map<String, String>> buildHeaders({
    Map<String, String>? extraHeaders,
  }) async {
    await Future<void>.delayed(AppConfig.simulatedAuthDelay);

    final headers = <String, String>{
      'Accept': 'application/json',
    };

    final token = await _localStorageService.getAuthToken();
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    if (extraHeaders != null) {
      headers.addAll(extraHeaders);
    }

    return headers;
  }
}

