import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubCatCategoryCard extends StatelessWidget {
  final String img;
  final String title;
  final bool isSelected;

  const SubCatCategoryCard({
    super.key,
    required this.img,
    required this.title,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w, right: 4.w),
      child: Container(
        constraints: BoxConstraints(minHeight: 75.h, maxWidth: 90.w),
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
        decoration: BoxDecoration(
          color: isSelected ? kWhite : kDAFAFF,
          borderRadius: BorderRadius.circular(22.r),
          border: isSelected
              ? Border.all(color: kDAFAFF.withOpacity(0.7), width: 1.5.w)
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image
            Container(
              height: 42.h,
              width: 85.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                image: DecorationImage(
                  image: AssetImage(img),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 5.h),
            // Title - Flexible to allow text wrapping
            Flexible(
              // child: CustomText(
              //   label: title,
              //   size: 10.sp,
              //   fontWeight: FontWeight.w700,
              //   color: kDark,
              //   textAlign: TextAlign.center,
              //   maxLines: 2,
              // ),
              child: Text(
                title,
                style: appStyle(11.sp, kDark, FontWeight.w600),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
