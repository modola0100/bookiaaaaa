import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/services/dio/dio_provider.dart';
import 'package:bookia/core/services/local/shered_preferences.dart';
import 'package:bookia/core/utils/theme.dart';
import 'package:flutter/material.dart';

/// The main function of the application.
///
/// This function ensures that the Flutter widgets are initialized, then
/// initializes the DioProvider and waits for the SharedPreference to
/// complete initialization before running the application.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioProvider.init();
  await SheredPreferences.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: Routes.route,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
    );
  }
}
