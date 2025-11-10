import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/widgets/coupon_card.dart';
import 'package:customer_app/app/global/widgets/icon_tap_image.dart';
import 'package:customer_app/app/screens/notifications/notification_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CouponsScreens extends StatelessWidget {
  const CouponsScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhite,
        scrolledUnderElevation: 0,
        title: Text(
          'Coupons',
          style: appStyle(18.sp, k232323, FontWeight.w600),
        ),
        actions: [
          SizedBox(width: 10.w),
          TapImageIcon(imageName: Appimages.personIcon, onTap: () {}),
          SizedBox(width: 10.w),
          TapImageIcon(
            imageName: Appimages.notiIcon,
            onTap: () => Get.to(() => NotificationScreens()),
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              CouponCard(
                backgroundColor: kPrimary,
                flatOffer: 'Flat ₹2000 off*',
                code: 'FINFIRST25',
                description: 'Subscription with our limited-time coupon.',
                expires: 'Expires 10 Oct 2025',
                onApplyCode: () {
                  print('Applying coupon FINFIRST25');
                },
              ),
              CouponCard(
                backgroundColor: kE2D02A,
                flatOffer: 'Flat ₹2000 off*',
                code: 'FINFIRST25',
                description: 'Subscription with our limited-time coupon.',
                expires: 'Expires 10 Oct 2025',
                onApplyCode: () {
                  print('Applying coupon FINFIRST25');
                },
              ),

              CouponCard(
                backgroundColor: kSecondary,
                flatOffer: 'Flat ₹2000 off*',
                code: 'FINFIRST25',
                description: 'Subscription with our limited-time coupon.',
                expires: 'Expires 10 Oct 2025',
                onApplyCode: () {
                  print('Applying coupon FINFIRST25');
                },
              ),

              CouponCard(
                backgroundColor: kGrey200,
                flatOffer: 'Flat ₹2000 off*',
                code: 'FINFIRST25',
                description: 'Subscription with our limited-time coupon.',
                expires: 'Expires 10 Oct 2025',
                onApplyCode: () {
                  print('Applying coupon FINFIRST25');
                },
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
