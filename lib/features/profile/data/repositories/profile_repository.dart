import 'package:dio/dio.dart';
import 'package:bookia/core/services/api_service.dart';
import 'package:bookia/features/profile/data/models/profile_model.dart';

class ProfileRepository {
  final ApiService _apiService;

  ProfileRepository(this._apiService);

  Future<ProfileModel> getProfile() async {
    try {
      final response = await _apiService.get('/profile');
      return ProfileModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to get profile: ${e.message}');
    }
  }

  Future<ProfileModel> updateProfile({
    String? name,
    String? phone,
    String? avatar,
  }) async {
    try {
      final data = {
        if (name != null) 'name': name,
        if (phone != null) 'phone': phone,
        if (avatar != null) 'avatar': avatar,
      };

      final response = await _apiService.patch('/profile', data: data);

      return ProfileModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to update profile: ${e.message}');
    }
  }

  Future<void> resetPassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      await _apiService.post(
        '/profile/reset-password',
        data: {'old_password': oldPassword, 'new_password': newPassword},
      );
    } on DioException catch (e) {
      throw Exception('Failed to reset password: ${e.message}');
    }
  }
}
