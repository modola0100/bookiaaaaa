import 'package:bookia/features/auth/data/models/auth_params.dart';
import 'package:bookia/features/auth/data/repo/auth_repo.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var userNameController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var pinController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmNewPasswordController = TextEditingController();
  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;
  bool isConfirmNewPasswordVisible = true;
  bool isNewPasswordVisible = true;

  register() async {
    emit(AuthLoadingState());
    var res = await AuthRepo.register(
      AuthParams(
        name: userNameController.text,
        email: emailController.text,
        password: passwordController.text,
        passwordConfirmation: confirmPasswordController.text,
      ),
    );
    if (res != null && res.status == 201) {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState(message: 'Register Failed'));
    }
  }

  login() async {
    emit(AuthLoadingState());
    var res = await AuthRepo.login(
      AuthParams(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
    if (res != null && res.status == 200) {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState(message: 'Login Failed'));
    }
  }

  forgetPassword() async {
    emit(AuthLoadingState());
    var res = await AuthRepo.forgetpassword(emailController.text);
    if (res != null && res.status == 200) {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState(message: 'Email Not Found'));
    }
  }

  otp() async {
    emit(AuthLoadingState());
    var res = await AuthRepo.otp(
      emailController.text,
      int.parse(pinController.text),
    );
    if (res != null && res.status == 200) {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState(message: 'OTP Failed'));
    }
  }

  resetPassword(int code) async {
    emit(AuthLoadingState());
    var res = await AuthRepo.resetPassword(
      code,
      newPasswordController.text,
      confirmNewPasswordController.text,
    );
    if (res != null && res.status == 200) {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState(message: 'Reset Password Failed'));
    }
  }
}
