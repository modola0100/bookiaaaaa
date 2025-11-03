import 'package:dio/dio.dart';
import 'package:bookia/core/services/api_service.dart';
import 'package:bookia/features/profile/data/repositories/profile_repository.dart';
import 'package:bookia/features/profile/cubit/profile_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Injector {
  static Dio? _dio;
  static SharedPreferences? _prefs;
  static ApiService? _apiService;
  static ProfileRepository? _profileRepository;
  static ProfileCubit? _profileCubit;

  static Future<void> init() async {
    _dio = Dio();
    _prefs = await SharedPreferences.getInstance();
    _apiService = ApiService(_dio!, _prefs!);
    _profileRepository = ProfileRepository(_apiService!);
    _profileCubit = ProfileCubit(_profileRepository!);
  }

  static ProfileCubit get profileCubit {
    if (_profileCubit == null) {
      throw Exception('Injector not initialized. Call init() first.');
    }
    return _profileCubit!;
  }
}
