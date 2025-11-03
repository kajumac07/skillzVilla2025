import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SubscriptionPlanPricingScreen extends StatelessWidget {
  const SubscriptionPlanPricingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAF9F4),

      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xffD4E7F6), Color(0xffFFF8E7)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: CircleAvatar(
                        backgroundColor: kWhite,
                        child: Icon(Icons.arrow_back, color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Text(
                  "EXCITING",
                  style: appStyle(20.sp, kSecondary, FontWeight.bold),
                ),
                SizedBox(height: 2.h),
                Text(
                  "PLANS & PRICING",
                  style: appStyle(18.sp, kGrey400, FontWeight.bold),
                ),
                SizedBox(height: 2.h),
                Text(
                  "Choose from our three plans",
                  style: appStyle(14.sp, kGrey300, FontWeight.w500),
                ),
                SizedBox(height: 20.h),

                // Plan Cards
                _buildPlanCard(
                  duration: "1 Month",
                  price: "₹ 399",
                  benefits: [
                    "Subscription Plan",
                    "Subscription Plan",
                    "Subscription Plan",
                  ],
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xffEBDC7C),
                      Color(0xffF29D65),
                      Color(0xffF85153),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                SizedBox(height: 16.h),

                _buildPlanCard(
                  duration: "3 Month",
                  price: "₹ 699",
                  benefits: [
                    "Subscription Plan",
                    "Subscription Plan",
                    "Subscription Plan",
                  ],
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xffEBDC7C),
                      Color(0xffF29D65),
                      Color(0xffF85153),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                SizedBox(height: 16.h),

                _buildPlanCard(
                  duration: "6 Month",
                  price: "₹ 999",
                  benefits: [
                    "Subscription Plan",
                    "Subscription Plan",
                    "Subscription Plan",
                  ],
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xffEBDC7C),
                      Color(0xffF29D65),
                      Color(0xffF85153),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),

                SizedBox(height: 30.h),

                // Continue Button
                CircularButton(
                  buttonColor: kPrimary,
                  buttonText: "Continue",
                  onPressed: () => Get.to(() => RootScreen()),
                  width: width,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required String duration,
    required String price,
    required List<String> benefits,
    required Gradient gradient,
  }) {
    final double horizontalPadding = 16.w;
    final double heartContainerWidth = 60.w;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gradient Header
              Container(
                height: 55.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                  ),
                ),
                padding: EdgeInsets.only(
                  left: heartContainerWidth / 1.2 + horizontalPadding,
                  right: horizontalPadding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Duration Text (starts after the heart container area)
                    Text(
                      duration,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    // Price Text
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              // Card Body (Benefits)
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 16.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: benefits.map((e) => _buildBenefitRow(e)).toList(),
                ),
              ),
            ],
          ),
        ),

        // 2. The separate Heart Icon Container (positioned on top)
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            height: 55.h,
            width: heartContainerWidth,
            decoration: BoxDecoration(
              color: const Color(0xffFDE6C1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                bottomRight: Radius.circular(12.r),
              ),
            ),
            child: Center(
              child: Icon(
                Icons.favorite_border,
                color: const Color(0xff6C6C6C),
                size: 20.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBenefitRow(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          // Custom checkmark icon
          Container(
            width: 18.w,
            height: 18.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffD04D4D), // Red-ish checkmark background
            ),
            child: Icon(Icons.check, color: Colors.white, size: 12.sp),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 14.sp, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
