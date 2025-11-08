import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/global/models/provider_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProviderCard extends StatelessWidget {
  final ProviderModel provider;
  final VoidCallback? onTap;
  const ProviderCard({super.key, required this.provider, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// ⭐ Rating
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 46.w,
              height: 22.h,
              decoration: BoxDecoration(
                color: kSurfaceBg,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 14),
                  SizedBox(width: 2.w),
                  Text(
                    provider.rating.toString(),
                    style: appStyle(
                      10.sp,
                      const Color(0xff7A7A7A),
                      FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// 👤 Image
          CircleAvatar(
            backgroundImage: AssetImage(provider.imageUrl),
            radius: 28.r,
          ),
          SizedBox(height: 8.h),

          /// 🧑‍🔧 Name & Role
          Text(
            provider.name,
            style: appStyle(14.sp, kGrey400, FontWeight.w600),
          ),
          Text(
            provider.role,
            style: appStyle(10.sp, kGrey100, FontWeight.w500),
          ),

          SizedBox(height: 10.h),

          /// 💰 Price & Old Price
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: kWhite,
                  border: Border.all(color: kGreenAccent),
                  borderRadius: BorderRadius.circular(7.r),
                ),
                child: Text(
                  "₹${provider.price.toStringAsFixed(0)}",
                  style: appStyle(14.sp, kGreenAccent, FontWeight.w500),
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                "₹${provider.oldPrice.toStringAsFixed(0)}",
                style: TextStyle(
                  color: kGrey100,
                  decoration: TextDecoration.lineThrough,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          /// 🔘 Book Now & Arrow Button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  height: 36.h,
                  decoration: BoxDecoration(
                    color: surface200,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Text(
                      "Add to cart",
                      style: appStyle(13.sp, k232323, FontWeight.w500),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              GestureDetector(
                onTap: onTap,
                child: CircleAvatar(
                  backgroundColor: kSecondary,
                  radius: 18.r,
                  child: Icon(Icons.arrow_outward, color: kWhite, size: 18.sp),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
