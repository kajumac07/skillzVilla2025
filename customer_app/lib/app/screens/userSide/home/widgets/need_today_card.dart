import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NeedTodayCard extends StatelessWidget {
  const NeedTodayCard({super.key, required this.image, required this.title});
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Image section
          Stack(
            children: [
              Container(
                height: 100.h,
                width: 105.w,
                decoration: BoxDecoration(
                  color: kthemeYellow,
                  borderRadius: BorderRadius.circular(22.r),
                ),
              ),

              Positioned(
                top: 15.h,
                bottom: 4.h,
                left: 4.w,
                right: 4.w,
                child: Container(
                  height: 60.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                    // color: kRed,
                    borderRadius: BorderRadius.circular(25.r),
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          //title section
          CustomText(label: title, size: 11.sp, fontWeight: FontWeight.w700),
        ],
      ),
    );
  }
}
