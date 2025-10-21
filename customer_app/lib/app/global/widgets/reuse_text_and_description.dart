import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReUseRowTextAndDetail extends StatelessWidget {
  const ReUseRowTextAndDetail({
    super.key,
    required this.title,
    required this.detail,
  });
  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomText(
          label: title,
          size: 14.sp,
          color: k232323,
          fontWeight: FontWeight.w700,
        ),
        Container(
          // color: kRed,
          width: 220.w,
          child: Text(
            detail,
            maxLines: 3,
            style: appStyle(14.sp, kGrey200, FontWeight.w300),
          ),
        ),
      ],
    );
  }
}
