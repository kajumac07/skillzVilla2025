import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
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
        height: 75.h,
        width: 90.w,
        decoration: BoxDecoration(
          color: isSelected ? kWhite : kDAFAFF,
          borderRadius: BorderRadius.circular(22.r),
          border: isSelected ? Border.all(color: kDAFAFF, width: 2.w) : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image
            Container(
              height: 42.h,
              width: 79.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                image: DecorationImage(
                  image: AssetImage(img),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            // Title
            CustomText(
              label: title,
              size: 11.sp,
              fontWeight: FontWeight.w700,
              color: kDark,
            ),
          ],
        ),
      ),
    );
  }
}
