import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_divider.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/screens/providerSide/jobQueue/widgets/job_invoice_detail.dart';
import 'package:customer_app/app/screens/providerSide/jobQueue/widgets/job_report_issue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class JobQueueDetailsScreen extends StatefulWidget {
  const JobQueueDetailsScreen({super.key, required this.selectedIndex});
  final int selectedIndex;

  @override
  State<JobQueueDetailsScreen> createState() => _JobQueueDetailsScreenState();
}

class _JobQueueDetailsScreenState extends State<JobQueueDetailsScreen> {
  late int selectedIndex;

  final List<String> tabs = ["New", "Ongoing", "Completed"];
  final List<IconData> icons = [
    Icons.work_outline,
    Icons.access_time,
    Icons.verified_outlined,
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: CustomText(
          label: "Job Queue Details",
          size: 18.sp,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SafeArea(
        child: Container(
          width: width,
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.all(8.w),
          margin: EdgeInsets.all(8.h),
          child: Column(
            children: [
              /// Segmented TabBar
              Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: kSecondaryLight.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(40.r),
                ),
                child: Row(
                  children: List.generate(tabs.length, (index) {
                    final bool isSelected = selectedIndex == index;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => selectedIndex = index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeInOut,
                          margin: EdgeInsets.symmetric(horizontal: 3.w),
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          decoration: BoxDecoration(
                            color: isSelected ? kSecondary : kWhite,
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                icons[index],
                                size: 18.sp,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black54,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                tabs[index],
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),

              SizedBox(height: 20.h),

              /// Body Section
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      // Booking Details Card
                      JobInfoCard(
                        title: "Booking Details",
                        gradient: const LinearGradient(
                          colors: [Color(0xffE6E6E6), Color(0xffFFDDD3)],
                        ),
                        children: [
                          const DetailsListTileCard(
                            title: "Booking ID:",
                            subTitle: "Cleaning Service",
                          ),
                          const DetailsListTileCard(
                            title: "Customer:",
                            subTitle: "Rohan Mehta",
                          ),
                          const DetailsListTileCard(
                            title: "Location:",
                            subTitle: "Green Residency, Sector 45",
                          ),
                          const DetailsListTileCard(
                            title: "Date & Time:",
                            subTitle: "21 Sept 2025, 2:00 PM",
                          ),
                          const DetailsListTileCard(
                            title: "Service:",
                            subTitle: "Plumbing Tap Fix",
                          ),
                          if (selectedIndex == 1)
                            const DetailsListTileCard(
                              title: "Status:",
                              subTitle: "At Job",
                            ),
                          if (selectedIndex == 2)
                            const DetailsListTileCard(
                              title: "Earnings:",
                              subTitle: "₹1,200",
                            ),
                        ],
                      ),

                      SizedBox(height: 20.h),

                      // Employee Details
                      JobInfoCard(
                        title: "Employee Details",
                        gradient: const LinearGradient(
                          colors: [Color(0xffE6E6E6), Color(0xffFFDDD3)],
                        ),
                        children: const [
                          DetailsListTileCard(
                            title: "Employee ID:",
                            subTitle: "7665HBH876",
                          ),
                          DetailsListTileCard(
                            title: "Employee Name:",
                            subTitle: "Rahul Sharma",
                          ),
                        ],
                      ),

                      SizedBox(height: 20.h),

                      // Feedback Section (only for completed)
                      if (selectedIndex == 2)
                        JobInfoCard(
                          title: "Customer Feedback",
                          backgroundColor: const Color(0xffF9F7F7),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  label: "Good work but came 15 mins late",
                                  size: 14.sp,
                                  color: kGrey200,
                                ),
                                Row(
                                  children: List.generate(
                                    5,
                                    (index) => const Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 2,
                                      ),
                                      child: Icon(
                                        Icons.star,
                                        color: Color(0xffE2D02A),
                                        size: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                      SizedBox(height: 50.h),

                      // Buttons
                      CircularButton(
                        buttonColor: kPrimary,
                        buttonText: getPrimaryButtonText(),
                        onPressed: onPrimaryPressed,
                        height: 48.h,
                        width: width,
                        textSize: 16.sp,
                      ),
                      SizedBox(height: 5.h),
                      CircularButton(
                        buttonColor: const Color(0xffE3E8EC),
                        buttonText: getSecondaryButtonText(),
                        onPressed: onSecondaryPressed,
                        height: 48.h,
                        width: width,
                        textSize: 16.sp,
                        textColor: kGrey400,
                      ),
                      // SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// --- BUTTON LOGIC ---
  String getPrimaryButtonText() {
    switch (selectedIndex) {
      case 0:
        return "Accept";
      case 1:
        return "Start Job";
      case 2:
        return "Download Invoice";
      default:
        return "";
    }
  }

  String getSecondaryButtonText() {
    switch (selectedIndex) {
      case 0:
        return "Reject";
      case 1:
        return "Complete Job";
      case 2:
        return "Report Issue";
      default:
        return "";
    }
  }

  void onPrimaryPressed() {
    switch (selectedIndex) {
      case 0:
        // TODO: handle Accept
        print("Job Accepted");
        break;
      case 1:
        // TODO: handle Start Job
        print("Job Started");
        break;
      case 2:
        Get.to(() => JobInvoiceDetailScreen());
        break;
    }
  }

  void onSecondaryPressed() {
    switch (selectedIndex) {
      case 0:
        print("Job Rejected");
        break;
      case 1:
        print("Job Completed");
        break;
      case 2:
        Get.to(() => ReportJobScreen());
        break;
    }
  }
}

class DetailsListTileCard extends StatelessWidget {
  const DetailsListTileCard({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      margin: EdgeInsets.symmetric(vertical: 2.h),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        leading: CustomText(
          label: title,
          size: 14.sp,
          color: kGrey200,
          fontWeight: FontWeight.w500,
        ),
        trailing: CustomText(
          label: subTitle,
          size: 14.sp,
          color: kGrey300,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class JobInfoCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final Color? backgroundColor;
  final Gradient? gradient;

  const JobInfoCard({
    super.key,
    required this.title,
    required this.children,
    this.backgroundColor,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: backgroundColor,
        gradient: gradient,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomText(label: title, size: 16.sp, color: kGrey400),
          ),
          SizedBox(height: 2.h),
          CustomDivider(color: gradient != null ? kWhite : kGrey100),
          SizedBox(height: 2.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
