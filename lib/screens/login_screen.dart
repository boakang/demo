import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view_app/demo/bloc_demo/demo_bloc.dart';

class LoginScreen extends StatefulWidget {
  final String projectCode;

  const LoginScreen({Key? key, required this.projectCode}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng Nhập')),
      body: BlocListener<DemoBloc, DemoState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.pushNamed(context, '/home', arguments: {
              'userId': state.userId,
              'userName': state.userName,
              'projectCode': state.projectCode,
            });
          } else if (state is LoginFailedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Tên Đăng Nhập',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Mật Khẩu',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              BlocBuilder<DemoBloc, DemoState>(
                builder: (context, state) {
                  final isLoading = state is LoggingInState;
                  return ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                      final username = _usernameController.text;
                      final password = _passwordController.text;
                      
                      if (username.isEmpty || password.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin')),
                        );
                        return;
                      }
                      
                      context.read<DemoBloc>().add(LoginEvent(
                        username: username,
                        password: password,
                        projectCode: widget.projectCode,
                      ));
                    },
                    child: isLoading
                        ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                        : const Text('Đăng Nhập'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
