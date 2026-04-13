import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile_app/core_app/formatter/no_leading_space_formatter.dart';
import 'package:mobile_app/core_app/style/app_colors.dart';
import 'package:mobile_app/core_app/widgets/general_button.dart';
import 'package:mobile_app/core_app/widgets/general_text_field.dart';
import 'package:mobile_app/core_app/widgets/loading_view.dart';
import 'package:mobile_app/view_app/demo/bloc_demo/demo_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _projectCodeController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordHidden = true;

  @override
  void dispose() {
    _projectCodeController.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitProjectCode() {
    context.read<DemoBloc>().add(
          ValidateProjectEvent(_projectCodeController.text.trim()),
        );
  }

  void _submitLogin(String projectCode) {
    context.read<DemoBloc>().add(
          LoginEvent(
            username: _userNameController.text.trim(),
            password: _passwordController.text,
            projectCode: projectCode.trim(),
          ),
        );
  }

  Future<void> _showResultDialog(
    BuildContext context, {
    required String title,
    required String message,
    required Color color,
    required IconData icon,
  }) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: color.withOpacity(0.12),
                      child: Icon(icon, color: color, size: 26),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 18),
                    GeneralButton(
                      text: 'Đóng',
                      onPressed: () => Navigator.of(dialogContext).pop(),
                      backgroundColor: color,
                      height: 42,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: IconButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  icon: const Icon(Icons.close),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DemoBloc, DemoState>(
      listener: (context, state) async {
        if (state is ProjectValidationFailedState) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: AppColors.error,
              ),
            );
          return;
        }

        if (state is LoginFailedState) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: AppColors.error,
              ),
            );
          return;
        }

        if (state is LoginSuccessState) {
          await _showResultDialog(
            context,
            title: 'Đăng nhập thành công',
            message: 'Xin chào ${state.userName}',
            color: AppColors.success,
            icon: Icons.verified,
          );
        }
      },
      builder: (context, state) {
        final isBusy = state is ValidatingProjectState || state is LoggingInState;
        
        // Mặc định: nhập project code. Khi validate ok -> hiện form login.
        String projectCode = _projectCodeController.text;
        if (state is ProjectValidatedState) {
          projectCode = state.projectCode;
        }
        if (state is LoginSuccessState) {
          projectCode = state.projectCode;
        }

        final isLoginPhase = state is ProjectValidatedState ||
            state is LoggingInState ||
            state is LoginFailedState ||
            state is LoginSuccessState;

        return Stack(
          children: [
            const _LoginBackground(),
            SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  const _LoginHeader(),
                  const SizedBox(height: 18),
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 380),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 250),
                            child: isLoginPhase
                                ? _LoginCard(
                                    key: const ValueKey('login_form'),
                                    isLoading: isBusy,
                                    projectCode: projectCode,
                                    userNameController: _userNameController,
                                    passwordController: _passwordController,
                                      isPasswordHidden: _isPasswordHidden,
                                      onTogglePasswordVisibility: () {
                                        setState(() {
                                          _isPasswordHidden = !_isPasswordHidden;
                                        });
                                      },
                                    onSubmit: () => _submitLogin(projectCode),
                                  )
                                : _ProjectCodeCard(
                                    key: const ValueKey('project_code'),
                                    isLoading: isBusy,
                                    controller: _projectCodeController,
                                    onSubmit: _submitProjectCode,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            if (isBusy)
              const Positioned.fill(
                child: ColoredBox(
                  color: Color(0x22000000),
                  child: LoadingView(message: 'Đang xử lý...'),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _LoginBackground extends StatelessWidget {
  const _LoginBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF5F7FF), Color(0xFFE9EEFF), Color(0xFF24408E)],
          stops: [0.0, 0.42, 1.0],
        ),
      ),
      child: Stack(
        children: const [
          Positioned(
            top: -30,
            left: -20,
            child: _GlowCircle(size: 220),
          ),
          Positioned(
            bottom: -40,
            right: -20,
            child: _GlowCircle(size: 180),
          ),
        ],
      ),
    );
  }
}

class _GlowCircle extends StatelessWidget {
  const _GlowCircle({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.14),
      ),
    );
  }
}

class _LoginHeader extends StatelessWidget {
  const _LoginHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CircleAvatar(
          radius: 34,
          backgroundColor: Colors.white,
          child: Icon(Icons.apartment_rounded, color: AppColors.primary, size: 34),
        ),
        SizedBox(height: 10),
        Text(
          'HQSOFT',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
            letterSpacing: 1.1,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'eSales SFA  •  Login Bloc demo',
          style: TextStyle(
            fontSize: 13,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _ProjectCodeCard extends StatelessWidget {
  const _ProjectCodeCard({
    super.key,
    required this.controller,
    required this.onSubmit,
    required this.isLoading,
  });

  final TextEditingController controller;
  final VoidCallback onSubmit;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Card(
      key: const ValueKey('project-code-card'),
      elevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 22, 18, 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.work_outline_rounded, size: 30, color: AppColors.primary),
            const SizedBox(height: 16),
            GeneralTextField(
              controller: controller,
              labelText: 'Mã dự án',
              hintText: 'Mã dự án',
              prefixIcon: const Icon(Icons.badge_outlined),
              inputFormatters: const [NoLeadingSpaceFormatter()],
            ),
            const SizedBox(height: 14),
            GeneralButton(
              text: 'Bắt đầu',
              isLoading: isLoading,
              onPressed: onSubmit,
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginCard extends StatelessWidget {
  const _LoginCard({
    super.key,
    required this.projectCode,
    required this.userNameController,
    required this.passwordController,
    required this.isPasswordHidden,
    required this.onTogglePasswordVisibility,
    required this.onSubmit,
    required this.isLoading,
  });

  final String projectCode;
  final TextEditingController userNameController;
  final TextEditingController passwordController;
  final bool isPasswordHidden;
  final VoidCallback onTogglePasswordVisibility;
  final VoidCallback onSubmit;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Card(
      key: const ValueKey('login-card'),
      elevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 20, 18, 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Đăng nhập',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            GeneralTextField(
              controller: userNameController,
              labelText: 'Tên đăng nhập (trùng Name)',
              hintText: 'Ví dụ: Nguyen Quoc An',
              prefixIcon: const Icon(Icons.person_outline),
              inputFormatters: const [NoLeadingSpaceFormatter()],
            ),
            const SizedBox(height: 12),
            GeneralTextField(
              controller: passwordController,
              labelText: 'Mật khẩu',
              hintText: 'Mật khẩu',
              prefixIcon: const Icon(Icons.lock_outline),
              obscureText: isPasswordHidden,
              suffixIcon: IconButton(
                onPressed: onTogglePasswordVisibility,
                icon: Icon(
                  isPasswordHidden ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                ),
              ),
              inputFormatters: const [NoLeadingSpaceFormatter()],
            ),
            const SizedBox(height: 14),
            GeneralButton(
              text: 'Đăng nhập',
              isLoading: isLoading,
              onPressed: onSubmit,
            ),
            const SizedBox(height: 12),
            if (projectCode.isNotEmpty) ...[
              const SizedBox(height: 6),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Mã dự án: $projectCode',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SuccessCard extends StatelessWidget {
  const _SuccessCard({
    super.key,
    required this.message,
    required this.onReset,
  });

  final String message;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    return Card(
      key: const ValueKey('success-card'),
      elevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 24, 18, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: AppColors.success.withOpacity(0.12),
              child: const Icon(Icons.check_circle, color: AppColors.success, size: 32),
            ),
            const SizedBox(height: 16),
            const Text(
              'Đăng nhập thành công',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 16),
            GeneralButton(
              text: 'Đăng nhập lại',
              onPressed: onReset,
              backgroundColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}

