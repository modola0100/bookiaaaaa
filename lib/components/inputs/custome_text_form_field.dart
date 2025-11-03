import 'package:bookia/core/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomeTextFormField extends StatelessWidget {
  const CustomeTextFormField({super.key, required this.title, this.suffix, required this.controller, this.validator, this.obscureText = false, this.prefix, this.onChanged, this.readOnly = false, this.onTap});

  final String title;
  final Widget? suffix;
  final Widget? prefix;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Function(String)? onChanged;
  final bool readOnly;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly,
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,
      maxLines: 1,
      decoration: InputDecoration(hintText: title, fillColor: AppColors.inputColor, filled: true, suffixIcon: suffix, prefixIcon: prefix),
      controller: controller,
    );
  }
}
