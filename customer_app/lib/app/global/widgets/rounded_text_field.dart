import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedTextField extends StatelessWidget {
  const RoundedTextField({
    super.key,
    this.controller,
    required this.label,
    this.suffixIcon,
    required this.obscureText,
    required this.keyboardType,
    this.validator,
  });

  final TextEditingController? controller;
  final String label;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: appStyle(15, kDark, FontWeight.w200),
        // prefixIcon: Icon(icon, color: kPrimary.withOpacity(0.7)),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: kWhite,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13.r),
          borderSide: BorderSide.none,
        ),
      ),
      style: appStyle(16, kDark, FontWeight.normal),
    );
  }
}
