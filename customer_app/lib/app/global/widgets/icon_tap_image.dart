import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TapImageIcon extends StatelessWidget {
  const TapImageIcon({super.key, required this.imageName, required this.onTap});
  final String imageName;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(imageName, height: 24.h, width: 24.w),
    );
  }
}
