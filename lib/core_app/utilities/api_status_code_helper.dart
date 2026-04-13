class ApiStatusCodeHelper {
  const ApiStatusCodeHelper._();

  static bool isSuccess(int statusCode) {
    return statusCode >= 200 && statusCode < 300;
  }

  static String messageForStatusCode(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Yêu cầu không hợp lệ.';
      case 401:
        return 'Chưa được xác thực.';
      case 403:
        return 'Không có quyền truy cập.';
      case 404:
        return 'Không tìm thấy dữ liệu.';
      case 408:
        return 'Server phản hồi quá chậm.';
      case 500:
        return 'Lỗi hệ thống phía server.';
      case 502:
      case 503:
      case 504:
        return 'Dịch vụ tạm thời không khả dụng.';
      default:
        return 'HTTP $statusCode';
    }
  }

  static String? extractServerMessage(dynamic body) {
    if (body is Map<String, dynamic>) {
      final message = body['message'] ?? body['msg'] ?? body['errorMessage'];
      if (message is String && message.isNotEmpty) {
        return message;
      }
    }

    if (body is String && body.isNotEmpty) {
      return body;
    }

    return null;
  }
}

