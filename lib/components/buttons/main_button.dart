import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.title,
    this.textColor,
    this.backgroundColor,
    this.bordercolor,
    this.width = double.infinity,
    this.height = 56,
    required this.onPressed,
  });

  final String title;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? bordercolor;
  final double? width;
  final double? height;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          overlayColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10),
          ),
          backgroundColor: backgroundColor ?? AppColors.primaryColor,
          side: bordercolor != null
              ? BorderSide(color: AppColors.darkColor)
              : BorderSide.none,
        ),
        child: Text(
          title,
          style: TextStyles.styleSize18(
            color: textColor ?? AppColors.borderColor,
          ),
        ),
      ),
    );
  }
}
