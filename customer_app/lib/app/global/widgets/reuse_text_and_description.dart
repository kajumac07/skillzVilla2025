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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 8.w),
        SizedBox(
          width: 70.w,
          child: Text(
            "$title",
            style: appStyle(14.sp, k232323, FontWeight.w500),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            detail,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: appStyle(13.sp, kGrey200, FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
