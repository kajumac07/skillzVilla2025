import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedTextField extends StatelessWidget {
  const RoundedTextField({
    super.key,
    this.controller,
    required this.label,
    this.prefixIcon,
    this.suffixIcon,
    required this.obscureText,
    required this.keyboardType,
    this.validator,
    this.isBorderEnable = false,
    this.fillColor = kWhite,
    this.maxLines = 1,
  });

  final TextEditingController? controller;
  final String label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool isBorderEnable;
  final Color fillColor;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: appStyle(15, kDark, FontWeight.w200),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: fillColor,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13.r),
          borderSide: isBorderEnable
              ? BorderSide(color: Color(0xffCED6DE))
              : BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13.r),
          borderSide: isBorderEnable
              ? BorderSide(color: Color(0xffCED6DE))
              : BorderSide.none,
        ),
      ),
      style: appStyle(16, kDark, FontWeight.normal),
    );
  }
}
