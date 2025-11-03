import 'package:bookia/core/di/injector.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/services/dio/dio_provider.dart';
import 'package:bookia/core/services/local/shered_preferences.dart';
import 'package:bookia/core/utils/theme.dart';
import 'package:bookia/features/profile/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The main function of the application.
///
/// This function ensures that the Flutter widgets are initialized, then
/// initializes the DioProvider and waits for the SharedPreference to
/// complete initialization before running the application.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioProvider.init();
  await SheredPreferences.init();
  await Injector.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Injector.profileCubit,
      child: MaterialApp.router(
        routerConfig: Routes.route,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
