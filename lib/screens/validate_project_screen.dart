import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view_app/demo/bloc_demo/demo_bloc.dart';

class ValidateProjectScreen extends StatefulWidget {
  const ValidateProjectScreen({Key? key}) : super(key: key);

  @override
  State<ValidateProjectScreen> createState() => _ValidateProjectScreenState();
}

class _ValidateProjectScreenState extends State<ValidateProjectScreen> {
  final _projectCodeController = TextEditingController();

  @override
  void dispose() {
    _projectCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nhập Mã Dự Án')),
      body: BlocListener<DemoBloc, DemoState>(
        listener: (context, state) {
          if (state is ProjectValidatedState) {
            Navigator.pushNamed(context, '/login', arguments: state.projectCode);
          } else if (state is ProjectValidationFailedState) {
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
                controller: _projectCodeController,
                decoration: const InputDecoration(
                  labelText: 'Mã Dự Án',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              BlocBuilder<DemoBloc, DemoState>(
                builder: (context, state) {
                  final isLoading = state is ValidatingProjectState;
                  return ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                      final projectCode = _projectCodeController.text.trim();
                      if (projectCode.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Vui lòng nhập mã dự án')),
                        );
                        return;
                      }
                      context.read<DemoBloc>().add(ValidateProjectEvent(projectCode));
                    },
                    child: isLoading
                        ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                        : const Text('Xác Nhận'),
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
