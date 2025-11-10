import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.label,
    this.size = 16,
    this.color = kDark,
    this.fontWeight = FontWeight.w400,
  });
  final String label;
  final double size;
  final Color color;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(label, style: appStyle(size, color, fontWeight));
  }
}
