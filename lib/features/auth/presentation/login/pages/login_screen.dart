import 'package:bookia/components/app_bar/app_bar_widget.dart';
import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/inputs/custome_text_form_field.dart';
import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/navigator.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:bookia/features/auth/presentation/login/widgets/social_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return Scaffold(
      appBar: AppBarWidget(),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoadingState) {
            showDialog(
              context: context,
              builder: (context) {
                return Center(child: CircularProgressIndicator());
              },
            );
          } else if (state is AuthSuccessState) {
            pop(context);
            pushWithReplacement(context, Routes.mainscreen);
          } else if (state is AuthErrorState) {
            pop(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: SingleChildScrollView(
            child: Form(
              key: cubit.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome back! Glad\nto see you, Again!', style: TextStyles.styleSize30()),
                  Gap(32),
                  CustomeTextFormField(
                    title: 'Enter your email',
                    controller: cubit.emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      return null;
                    },
                  ),
                  Gap(15),
                  CustomeTextFormField(
                    title: 'Enter your password',
                    obscureText: cubit.isPasswordVisible,
                    controller: cubit.passwordController,
                    suffix: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              cubit.isPasswordVisible = !cubit.isPasswordVisible;
                            });
                          },
                          child: SvgPicture.asset(AppImages.eyesvg),
                        ),
                      ],
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      style: TextButton.styleFrom(overlayColor: Colors.transparent, padding: EdgeInsets.all(0)),
                      onPressed: () {
                        pushWithReplacement(context, Routes.forgetPassword);
                      },
                      child: Text('Forgot Password?', style: TextStyles.styleSize14()),
                    ),
                  ),
                  Gap(30),
                  MainButton(
                    title: 'Login',
                    onPressed: () {
                      if (cubit.formKey.currentState!.validate()) {
                        cubit.login();
                      }
                    },
                  ),
                  Gap(34),
                  SocialWidget(),
                  Gap(21),
                  GoogleAndApple(title: 'Google', image: SvgPicture.asset(AppImages.googlesvg)),
                  Gap(15),
                  GoogleAndApple(title: 'Apple', image: SvgPicture.asset(AppImages.applesvg)),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Don’t have an account?', style: TextStyles.styleSize14()),
          TextButton(
            style: TextButton.styleFrom(overlayColor: Colors.transparent),
            onPressed: () {
              pushWithReplacement(context, Routes.register);
            },
            child: Text('Register Now', style: TextStyles.styleSize14(color: AppColors.primaryColor)),
          ),
        ],
      ),
    );
  }
}
