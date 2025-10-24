import 'package:customer_app/app/core/constants/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FourtyTwoCircleIcon extends StatelessWidget {
  const FourtyTwoCircleIcon({
    super.key,
    required this.onTap,
    required this.imageName,
  });

  final void Function()? onTap;
  final String imageName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 42.h,
        width: 42.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: kGrey200, width: 1),
        ),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Image.asset(imageName, height: 24.h, width: 24.w),
        ),
      ),
    );
  }
}
