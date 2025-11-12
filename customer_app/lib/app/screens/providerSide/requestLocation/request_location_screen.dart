import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';

class RequestLocationScreen extends StatefulWidget {
  const RequestLocationScreen({super.key});

  @override
  State<RequestLocationScreen> createState() => _RequestLocationScreenState();
}

class _RequestLocationScreenState extends State<RequestLocationScreen> {
  bool isSubmitted = false; // track UI state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          label: "Relocation Request",
          size: 18.sp,
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 IMAGE — show only when not submitted
              if (!isSubmitted) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Stack(
                    children: [
                      Image.asset(
                        Appimages.requestLocationImage,
                        width: double.infinity,
                        height: 150.h,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: CustomText(
                          label: "New Location",
                          size: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),

                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8.w,
                        height: 8.h,
                        decoration: const BoxDecoration(
                          color: Colors.black38,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Container(
                        width: 16.w,
                        height: 8.h,
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
              ],

              // 🔹 Relocation Left
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: const Color(0xffF3F4F9),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      label: "Relocation Left :",
                      size: 14.sp,
                      color: kGrey300,
                      fontWeight: FontWeight.w500,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: CustomText(
                        // show 2/3 normally, 0/3 after submit
                        label: isSubmitted ? "0/3" : "2/3",
                        size: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14.h),

              // 🔹 New Area Select
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: const Color(0xffF3F4F9),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      label: "New Area Select :",
                      size: 14.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    const Icon(Icons.arrow_drop_down, color: Colors.black),
                  ],
                ),
              ),
              SizedBox(height: 14.h),

              // 🔹 Reason
              CustomText(
                label: "Reason",
                size: 14.sp,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 6.h),
              Container(
                height: 100.h,
                width: double.maxFinite,
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: const Color(0xffF3F4F9),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: CustomText(
                  label: "Enter......",
                  size: 14.sp,
                  color: Colors.black45,
                ),
              ),
              SizedBox(height: 20.h),

              // 🔹 HISTORY — show only when not submitted
              if (!isSubmitted) ...[
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            label: "History",
                            size: 14.sp,
                            color: kGrey300,
                            fontWeight: FontWeight.w600,
                          ),
                          InkWell(
                            onTap: () {},
                            child: const Icon(Icons.arrow_drop_up_rounded),
                          ),
                        ],
                      ),
                      CustomDivider(),
                      _buildHistoryItem(
                        "Raj Nagar, Delhi, 1262638",
                        "22 Oct, 2025",
                      ),
                      _buildHistoryItem(
                        "Rohtak, Haryana, 1262638",
                        "22 Oct, 2025",
                      ),
                      _buildHistoryItem(
                        "Raj Nagar, Delhi, 1262638",
                        "22 Oct, 2025",
                      ),
                      _buildHistoryItem(
                        "Raj Nagar, Delhi, 1262638",
                        "22 Oct, 2025",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
              ],

              // 🔹 Button Area
              CircularButton(
                buttonColor: kPrimary,
                buttonText: isSubmitted ? "Submit" : "Submit",
                onPressed: () {
                  setState(() {
                    // toggle between states
                    if (isSubmitted) {
                      isSubmitted = false; // reset UI
                    } else {
                      isSubmitted = true; // hide elements
                    }
                  });
                },
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryItem(String title, String date) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 16,
                backgroundImage: AssetImage(Appimages.locationProfile),
              ),
              SizedBox(width: 10.w),
              CustomText(label: title, size: 12.sp, color: kGrey400),
            ],
          ),
          CustomText(label: date, size: 10.sp, color: kGrey200),
        ],
      ),
    );
  }
}
