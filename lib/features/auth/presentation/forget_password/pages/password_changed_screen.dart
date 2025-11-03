import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/navigator.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class PasswordChangedScreen extends StatelessWidget {
  const PasswordChangedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppImages.successsvg),
              Gap(35),
              Text('Password Changed!', style: TextStyles.styleSize26()),
              Gap(3),
              Text(
                'Your password has been changed\nsuccessfully.',
                style: TextStyles.styleSize16(color: AppColors.greyColor),
                textAlign: TextAlign.center,
              ),
              Gap(40),
              MainButton(
                title: 'Back to Login',
                onPressed: () {
                  pushAndRemoveUntil(context, Routes.login);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
