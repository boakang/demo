// NOTE:
// File này hiện không được dùng trong luồng chạy của app (app dùng các màn trong lib/screens).
// Trước đây file có code tham chiếu tới LoginBloc / ApiClient(authHeaderService: ...) không tồn tại
// -> làm app không analyze/build được.
// Giữ lại file để không thay đổi cấu trúc thư mục, nhưng để trống để tránh lỗi.

import 'package:flutter/material.dart';

class DemoScreen extends StatelessWidget {
  const DemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

