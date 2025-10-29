import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/screens/providerSide/adsPromotion/widgets/banner_slots_booking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AdsPromotionScreen extends StatelessWidget {
  const AdsPromotionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final plans = [
      AdPlanModel(
        title: "Ad Starter Plan",
        subtitle: "Perfect your starters",
        days: "1 day & 7 days",
        screens: "5",
        color: kWhite,
        borderColor: kSecondaryLight,
        tagColor: kSecondary,
        tagIcon: Icons.bookmark,
        buttonColor: kPrimary,
        textColor: kSecondary,
      ),
      AdPlanModel(
        title: "Addon plan",
        subtitle: "Perfect your starters",
        days: "7 days - 14 days",
        screens: "Homescreen & 5-10 others",
        color: const Color(0xffFFEFEF),
        borderColor: const Color(0xffFFD6D6),
        tagText: "Recommended",
        tagColor: const Color(0xffD9534F),
        buttonColor: kPrimary,
        textColor: kPrimary,
        isRecommended: true,
      ),
      AdPlanModel(
        title: "PromoAd plan",
        subtitle: "Perfect your starters",
        days: "15 days - 30 days",
        screens: "Homescreen & 10 and more",
        color: kWhite,
        borderColor: Colors.transparent,
        tagColor: kSuccess,
        buttonColor: kPrimary,
        textColor: kSuccess,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: CustomText(
          label: "Ads",
          size: 18.sp,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            for (var plan in plans) ...[
              AdPlanCard(plan: plan),
              SizedBox(height: 16.h),
            ],
          ],
        ),
      ),
    );
  }
}

class AdPlanModel {
  final String title;
  final String subtitle;
  final String days;
  final String screens;
  final Color color;
  final Color borderColor;
  final Color buttonColor;
  final Color tagColor;
  final IconData? tagIcon;
  final String? tagText;
  final Color textColor;
  final bool isRecommended;

  AdPlanModel({
    required this.title,
    required this.subtitle,
    required this.days,
    required this.screens,
    required this.color,
    required this.borderColor,
    required this.buttonColor,
    required this.tagColor,
    this.tagIcon,
    this.tagText,
    this.textColor = kGrey300,
    this.isRecommended = false,
  });
}

class AdPlanCard extends StatelessWidget {
  final AdPlanModel plan;
  const AdPlanCard({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(12.r),
            // border: Border.all(color: plan.borderColor),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: const Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              plan.isRecommended
                  ? Center(
                      child: CustomText(
                        label: "Recommended",
                        size: 16.sp,
                        color: plan.textColor,
                      ),
                    )
                  : SizedBox(),
              SizedBox(height: plan.isRecommended ? 12.h : 0.h),

              Container(
                padding: EdgeInsets.all(plan.isRecommended ? 14.w : 0),
                decoration: BoxDecoration(
                  color: plan.color,
                  borderRadius: BorderRadius.circular(12.r),
                  // border: Border.all(color: plan.borderColor),
                  boxShadow: [
                    // BoxShadow(
                    //   color: Colors.black12,
                    //   offset: const Offset(0, 2),
                    //   blurRadius: 4,
                    // ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// --- Top Row ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          label: plan.title,
                          size: 22.sp,
                          color: plan.textColor,
                          fontWeight: FontWeight.bold,
                        ),
                        CustomText(
                          label: plan.subtitle,
                          size: 13.sp,
                          color: kGrey300,
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),

                    /// --- Info Section ---
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 4.h,
                        horizontal: 4.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          infoText("Days :", plan.days),
                          SizedBox(height: 4.h),
                          infoText("Screens :", plan.screens),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /// --- Add to Cart Button ---
              SizedBox(height: 10.h),

              CircularButton(
                buttonColor: plan.buttonColor,
                buttonText: "Add to Cart",
                onPressed: () => Get.to(() => BannerSlotsBookingScreen()),
                height: 40.h,
                width: width,
                textSize: 16.sp,
              ),
            ],
          ),
        ),

        /// --- Top Corner Tag / Badge ---
        if (plan.tagIcon != null)
          Positioned(
            top: -10,
            right: 12.w,
            child: Icon(plan.tagIcon, color: plan.tagColor, size: 22.sp),
          ),
      ],
    );
  }

  Widget infoText(String label, String value) {
    return Row(
      children: [
        CustomText(
          label: label,
          size: 18.sp,
          color: kGrey200,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(width: 4.w),
        Expanded(
          child: CustomText(
            label: value,
            size: 15.sp,
            color: kGrey300,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
