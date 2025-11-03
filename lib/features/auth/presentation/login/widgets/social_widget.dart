import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class SocialWidget extends StatelessWidget {
  const SocialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider()),
        Gap(10),
        Text('Or', style: TextStyles.styleSize14()),
        Gap(10),
        Expanded(child: Divider()),
      ],
    );
  }
}

class GoogleAndApple extends StatelessWidget {
  const GoogleAndApple({super.key, required this.title, required this.image});

  final String title;
  final SvgPicture image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderColor),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          image,
          Gap(10),
          Text('Sign in with ${title}', style: TextStyles.styleSize14()),
        ],
      ),
    );
  }
}
