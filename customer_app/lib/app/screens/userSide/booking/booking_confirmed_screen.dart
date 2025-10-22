import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/screens/userSide/booking/screens/booking_summary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BookingConfirmedScreen extends StatefulWidget {
  const BookingConfirmedScreen({super.key});

  @override
  State<BookingConfirmedScreen> createState() => _BookingConfirmedScreenState();
}

class _BookingConfirmedScreenState extends State<BookingConfirmedScreen> {
  @override
  void initState() {
    super.initState();
    //after 3 seconds navigate to booking summary screen
    Future.delayed(const Duration(seconds: 3), () {
      Get.to(() => BookingSummaryScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Booking Confirmed',
          style: appStyle(18.sp, k232323, FontWeight.w500),
        ),
        // centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // centers column vertically
          crossAxisAlignment: CrossAxisAlignment.center, // centers horizontally
          children: [
            // Image
            Container(
              height: 207.h,
              width: 145.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Appimages.bookingConfirmed),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            CustomText(
              label: "Booking Successful",
              size: 20.sp,
              color: kSecondary,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 5.h),
            CustomText(
              label: "You’re saving ₹15 on this order",
              size: 14.sp,
              color: k343434,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 100.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Appimages.mapIcon,
                  height: 24.h,
                  width: 24.h,
                  color: kSuccess,
                ),
                SizedBox(width: 5.w),
                CustomText(
                  label: "Luxmi Lok Sector 24, Panchkula, Haryana",
                  size: 12.sp,
                  color: kGrey300,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
