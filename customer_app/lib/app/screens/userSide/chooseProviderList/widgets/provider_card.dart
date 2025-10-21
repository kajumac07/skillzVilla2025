import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/global/models/provider_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProviderCard extends StatelessWidget {
  final ProviderModel provider;
  const ProviderCard({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 8.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 41.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: kSurfaceBg,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      Text(
                        provider.rating.toString(),
                        style: appStyle(
                          10.sp,
                          Color(0xff7A7A7A),
                          FontWeight.w100,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          CircleAvatar(
            backgroundImage: AssetImage(provider.imageUrl),
            radius: 28,
          ),
          SizedBox(height: 8.h),
          Text(
            provider.name,
            style: appStyle(14.sp, kGrey400, FontWeight.w600),
          ),
          Text(
            provider.role,
            style: appStyle(10.sp, kGrey100, FontWeight.bold),
          ),
          SizedBox(height: 6.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: 8.w,
                  right: 8.w,
                  top: 2.h,
                  bottom: 2.h,
                ),
                decoration: BoxDecoration(
                  color: kWhite,
                  border: Border.all(color: kGreenAccent),
                  borderRadius: BorderRadius.circular(7.r),
                ),
                child: Text(
                  "₹${provider.price.toStringAsFixed(0)}",
                  style: appStyle(15.sp, kGreenAccent, FontWeight.w300),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                "₹${provider.oldPrice.toStringAsFixed(0)}",
                style: TextStyle(
                  color: kGrey100,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.only(left: 7.0.w, right: 7.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 32.h,
                  width: 110.w,
                  decoration: BoxDecoration(
                    color: surface200,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(child: Text("Book Now")),
                ),
                Spacer(),
                CircleAvatar(
                  backgroundColor: kSecondary,
                  radius: 18.r,
                  child: Icon(Icons.arrow_outward, color: kWhite, size: 20.sp),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
