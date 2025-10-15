import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({
    super.key,
    required this.buttonColor,
    required this.buttonText,

    required this.onPressed,
    this.textColor = kWhite,
    this.width = 120,
    this.height = 45,
  });
  final Color buttonColor;
  final String buttonText;
  final Color textColor;
  final void Function()? onPressed;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
        minimumSize: Size(width, height),
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: 14.h),
      ),
      child: Text(
        buttonText,
        style: appStyle(15.sp, textColor, FontWeight.w500),
      ),
    );
  }
}
