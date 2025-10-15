import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedTextField extends StatelessWidget {
  const RoundedTextField({
    super.key,
    this.controller,
    required this.label,
    required this.icon,
    this.suffixIcon,
    required this.obscureText,
    required this.keyboardType,
    this.validator,
  });

  final TextEditingController? controller;
  final String label;
  final IconData icon;
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
        labelStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(icon, color: kPrimary.withOpacity(0.7)),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: kWhite,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.r),
          borderSide: BorderSide.none,
        ),
      ),
      style: appStylePoppins(16, kDark, FontWeight.normal),
    );
  }
}
