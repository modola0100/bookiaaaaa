import 'dart:developer';

import 'package:bookia/core/services/dio/dio_endpoint.dart';
import 'package:bookia/core/services/dio/dio_provider.dart';
import 'package:bookia/core/services/local/shered_preferences.dart';
import 'package:bookia/features/auth/data/models/auth_params.dart';
import 'package:bookia/features/auth/data/models/auth_response/auth_response.dart';
import 'package:bookia/features/auth/data/models/auth_response_forget_password/auth_response_forget_password.dart';
import 'package:bookia/features/auth/data/models/auth_response_login/auth_response_login.dart';
import 'package:bookia/features/auth/data/models/auth_response_otp/auth_response_otp.dart';
import 'package:bookia/features/auth/data/models/auth_response_reset_password/auth_response_reset_password.dart';

class AuthRepo {
  static Future<AuthResponse?> register(AuthParams params) async {
    try {
      var res = await DioProvider.post(
        path: Endpoint.register,
        data: params.toJson(),
      );
      if (res.statusCode == 201) {
        var body = res.data;
        return AuthResponse.fromJson(body);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<AuthResponseLogin?> login(AuthParams params) async {
    try {
      var res = await DioProvider.post(
        path: Endpoint.login,
        data: params.toJson(),
      );
      if (res.statusCode == 200) {
        var body = res.data;
        var saveUserdata = AuthResponseLogin.fromJson(body);
        SheredPreferences.saveUserData(saveUserdata.data);

        return saveUserdata;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<AuthResponseForgetPassword?> forgetpassword(
    String email,
  ) async {
    try {
      var res = await DioProvider.post(
        path: Endpoint.forget,
        data: {"email": email},
      );
      if (res.statusCode == 200) {
        var body = res.data;
        return AuthResponseForgetPassword.fromJson(body);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<AuthResponseOtp?> otp(String email, int code) async {
    try {
      var res = await DioProvider.post(
        path: Endpoint.otp,
        data: {"email": email, "verify_code": code},
      );
      if (res.statusCode == 200) {
        var body = res.data;
        return AuthResponseOtp.fromJson(body);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<AuthResponseResetPassword?> resetPassword(
    int code,
    String newPassword,
    String newPasswordConfirmation,
  ) async {
    try {
      var res = await DioProvider.post(
        path: Endpoint.resetPassword,
        data: {
          "verify_code": code,
          "new_password": newPassword,
          "new_password_confirmation": newPasswordConfirmation,
        },
      );
      if (res.statusCode == 200) {
        var body = res.data;
        return AuthResponseResetPassword.fromJson(body);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }
}
