import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/core_app/config/app_config.dart';
import 'package:mobile_app/core_app/style/app_theme.dart';
import 'package:mobile_app/data_app/repository/auth_repository.dart';
import 'package:mobile_app/data_app/remote/api_client.dart';
import 'package:mobile_app/data_app/remote/demo_api_client.dart';
import 'package:mobile_app/view_app/demo/bloc_demo/demo_bloc.dart';
import 'package:mobile_app/view_app/demo/demo_form.dart';
import 'package:mobile_app/screens/validate_project_screen.dart';
import 'package:mobile_app/screens/login_screen.dart';
import 'package:mobile_app/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DemoBloc(
        authRepository: AuthRepository(
          apiClient: LoginApiClient(ApiClient()),
        ),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConfig.appName,
        theme: AppTheme.lightTheme(),
        // Show HQSOFT styled demo UI first (project code -> login form).
        home: const Scaffold(body: SafeArea(child: LoginForm())),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/validate-project':
              return MaterialPageRoute(builder: (_) => const ValidateProjectScreen());
            case '/login':
              final projectCode = settings.arguments as String;
              return MaterialPageRoute(
                builder: (_) => LoginScreen(projectCode: projectCode),
              );
            case '/home':
              final args = settings.arguments as Map<String, String>;
              return MaterialPageRoute(
                builder: (_) => HomeScreen(
                  userId: args['userId']!,
                  userName: args['userName']!,
                  projectCode: args['projectCode']!,
                ),
              );
            default:
              return MaterialPageRoute(builder: (_) => const ValidateProjectScreen());
          }
        },
      ),
    );
  }
}

