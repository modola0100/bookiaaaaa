import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/navigator.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppImages.welcomepng,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(flex: 2),
                  SvgPicture.asset(AppImages.logosvg),
                  Text('Order Your Book Now!', style: TextStyles.styleSize20()),
                  Spacer(flex: 5),
                  MainButton(
                    title: 'Login',
                    onPressed: () {
                      pushTo(context, Routes.login);
                    },
                  ),
                  Gap(15),
                  MainButton(
                    title: 'Register',
                    textColor: AppColors.darkColor,
                    backgroundColor: AppColors.wightColor,
                    bordercolor: AppColors.darkColor,
                    onPressed: () {
                      pushTo(context, Routes.register);
                    },
                  ),
                  Spacer(flex: 1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
