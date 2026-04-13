import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String userId;
  final String userName;
  final String projectCode;

  const HomeScreen({
    Key? key,
    required this.userId,
    required this.userName,
    required this.projectCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trang Chủ')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login success',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Text(
              'Username: $userName',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            Text(
              'Project Code: $projectCode',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            Text(
              'User ID: $userId',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/validate-project',
                  (route) => false,
                );
              },
              child: const Text('Đăng Xuất'),
            ),
          ],
        ),
      ),
    );
  }
}
