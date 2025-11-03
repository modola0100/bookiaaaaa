import 'dart:developer';

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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class CreatPassword extends StatefulWidget {
  const CreatPassword({super.key, required this.otp});

  final int otp;

  @override
  State<CreatPassword> createState() => _CreatPasswordState();
}

class _CreatPasswordState extends State<CreatPassword> {
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
              barrierDismissible: false,
              builder: (context) =>
                  const Center(child: CircularProgressIndicator()),
            );
          } else if (state is AuthSuccessState) {
            pop(context);
            log('success');
            pushAndRemoveUntil(context, Routes.passwordChanged);
          } else if (state is AuthErrorState) {
            pop(context);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
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
                  Text('Create new password', style: TextStyles.styleSize30()),
                  Gap(10),
                  Text(
                    'Your new password must be unique from those\npreviously used.',
                    style: TextStyles.styleSize16(color: AppColors.greyColor),
                  ),
                  Gap(30),
                  CustomeTextFormField(
                    obscureText: cubit.isNewPasswordVisible,
                    title: 'New Password',
                    controller: cubit.newPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your new password';
                      }
                      return null;
                    },
                    suffix: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              cubit.isNewPasswordVisible =
                                  !cubit.isNewPasswordVisible;
                            });
                          },
                          child: SvgPicture.asset(AppImages.eyesvg),
                        ),
                      ],
                    ),
                  ),
                  Gap(15),
                  CustomeTextFormField(
                    obscureText: cubit.isConfirmNewPasswordVisible,

                    title: 'Confirm Password',
                    controller: cubit.confirmNewPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your new password';
                      } else if (value != cubit.newPasswordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    suffix: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              cubit.isConfirmNewPasswordVisible =
                                  !cubit.isConfirmNewPasswordVisible;
                            });
                          },
                          child: SvgPicture.asset(AppImages.eyesvg),
                        ),
                      ],
                    ),
                  ),

                  Gap(30),
                  MainButton(
                    title: 'Reset Password',
                    onPressed: () {
                      if (cubit.formKey.currentState!.validate()) {
                        cubit.resetPassword(widget.otp);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
