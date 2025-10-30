import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/screens/userSide/wallets/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PayoutRequestsScreen extends StatelessWidget {
  const PayoutRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> payouts = [
      {"date": "30 Jan 2025", "status": "Completed"},
      {"date": "25 Jan 2025", "status": "Inprogress"},
      {"date": "20 Jan 2025", "status": "Failed"},
      {"date": "18 Jan 2025", "status": "Processed"},
      {"date": "13 Jan 2025", "status": "Inprogress"},
      {"date": "10 Jan 2025", "status": "Completed"},
      {"date": "08 Jan 2025", "status": "Failed"},
      {"date": "03 Jan 2025", "status": "Completed"},
      {"date": "01 Jan 2025", "status": "Completed"},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        title: CustomText(
          label: "Payout Requests",
          size: 18.sp,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xffFFFBEF),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 22.r,
                        backgroundImage: const AssetImage(
                          Appimages.providerIcon,
                        ), // replace with your image
                      ),
                      SizedBox(width: 10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            label: "Ajmal’s",
                            size: 17.sp,
                            color: kGrey200,
                            fontWeight: FontWeight.w500,
                          ),
                          CustomText(
                            label: "Total Earnings",
                            size: 17.sp,
                            color: kGrey400,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ],
                  ),
                  CustomText(
                    label: "₹24,321.90",
                    size: 20.sp,
                    color: kGrey400,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            /// Request Payout Button
            CircularButton(
              buttonColor: kPrimary,
              buttonText: "Request Payout",
              onPressed: () => Get.to(() => WalletScreen()),
              height: 40.h,
              width: width,
            ),
            SizedBox(height: 25.h),

            /// Payouts List Header
            CustomText(
              label: "Payouts",
              size: 18.sp,
              color: kGrey400,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 10.h),

            /// Payout List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                children: payouts.map((item) {
                  final status = item["status"];
                  final colorScheme = _statusColors(status);
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 6.h),
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xffF9F7F7),
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today_outlined,
                              size: 18,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 8.w),
                            CustomText(
                              label: item["date"],
                              size: 14.sp,
                              color: kGrey400,
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme["bg"],
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: CustomText(
                            label: status,
                            size: 12.sp,
                            color: colorScheme["text"]!,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: 25.h),

            /// Footer Note
            Center(
              child: CustomText(
                label: "Next Payout Available on 12 April 2025",
                size: 13.sp,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  /// Helper for color mapping
  Map<String, Color> _statusColors(String status) {
    switch (status) {
      case "Completed":
        return {"bg": const Color(0xffE8F7EC), "text": const Color(0xff3ABF6D)};
      case "Inprogress":
        return {"bg": const Color(0xffE5F5FB), "text": const Color(0xff4DB5E4)};
      case "Failed":
        return {"bg": const Color(0xffFDE8E8), "text": const Color(0xffE85C5C)};
      case "Processed":
        return {"bg": const Color(0xffFFF6DA), "text": const Color(0xffE0B73F)};
      default:
        return {"bg": Colors.grey.shade200, "text": Colors.grey};
    }
  }
}
