class ApiException implements Exception {
  const ApiException({
    required this.message,
    this.statusCode,
    this.details,
  });

  final String message;
  final int? statusCode;
  final Object? details;

  factory ApiException.timeout() {
    return const ApiException(
      message: 'Kết nối quá thời gian chờ.',
    );
  }

  factory ApiException.network({Object? details}) {
    return ApiException(
      message: 'Không thể kết nối tới server.',
      details: details,
    );
  }

  factory ApiException.fromStatusCode(
    int statusCode, {
    String? serverMessage,
    Object? details,
  }) {
    return ApiException(
      statusCode: statusCode,
      message: serverMessage?.isNotEmpty == true
          ? serverMessage!
          : 'Server trả về lỗi ($statusCode).',
      details: details,
    );
  }

  @override
  String toString() {
    return 'ApiException(statusCode: $statusCode, message: $message)';
  }
}

