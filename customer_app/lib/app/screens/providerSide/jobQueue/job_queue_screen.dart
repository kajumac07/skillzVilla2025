import 'dart:developer';
import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/services/shared_pref.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/screens/providerSide/jobQueue/widgets/job_invoice_detail.dart';
import 'package:customer_app/app/screens/providerSide/jobQueue/widgets/job_queue_details_screen.dart';
import 'package:customer_app/app/screens/providerSide/jobQueue/widgets/job_report_issue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class JobsQueueScreen extends StatefulWidget {
  const JobsQueueScreen({super.key});

  @override
  State<JobsQueueScreen> createState() => _JobsQueueScreenState();
}

class _JobsQueueScreenState extends State<JobsQueueScreen> {
  int selectedIndex = 0;

  final List<String> tabs = ["New", "Ongoing", "Completed"];
  // final List<IconData> icons = [
  //   Icons.work_outline,
  //   Icons.access_time,
  //   Icons.verified_outlined,
  // ];

  final List<String> icons = [
    Appimages.newJob,
    Appimages.ongoingJob,
    Appimages.completedJob,
  ];

  String? userType;
  String? kycType;
  String displayName = "Loading...";
  final _sharedPref = AppSharedPrefData();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    userType = await _sharedPref.getUserType();
    kycType = await _sharedPref.getKycType();
    log("ProfileScreen → userType: $userType | kycType: $kycType");

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FD),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: CustomText(
          label: "Job Queue",
          size: 18.sp,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.w),
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
                              Image.asset(
                                icons[index],
                                height: 20.h,
                                width: 20.w,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black54,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                tabs[index],
                                style: TextStyle(
                                  fontSize: 12.sp,
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

              /// Tab Body
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      buildJobCard(selectedIndex),
                      SizedBox(height: 10.h),
                      buildJobCard(selectedIndex),
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

  /// Builds the job card UI dynamically based on tab
  Widget buildJobCard(int status) {
    return GestureDetector(
      onTap: () {
        Get.to(() => JobQueueDetailsScreen(selectedIndex: status));
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: kWhite,
          border: Border.all(color: const Color(0xffCED6DE)),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// TOP ROW - Booking info and Status badges
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: width,
              // color: kRed,
              padding: EdgeInsets.symmetric(horizontal: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        label: "BK#20250921",
                        size: 12.sp,
                        color: kGrey400,
                      ),
                      SizedBox(height: 2.h),
                      CustomText(
                        label: "Plumbing - Tap Fix",
                        size: 16.sp,
                        color: kGrey300,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 2.h),

                      CustomText(
                        label: "Palm Heights Tower B",
                        size: 12.sp,
                        color: kGrey200,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  _buildStatusWidget(status),
                ],
              ),
            ),

            SizedBox(height: 2.h),

            /// MIDDLE SECTION - Customer and Date info
            Row(
              children: [
                buildReusableIconText(
                  const Color(0xffF9F7F7),
                  Icons.person,
                  "Rohan Mehta",
                  kGrey200,
                ),
                SizedBox(width: 10.w),
                buildReusableIconText(
                  const Color(0xffF9F7F7),
                  Icons.calendar_month,
                  "21 Sept 2025, 2:00 PM",
                  kGrey200,
                ),
              ],
            ),

            SizedBox(height: 8.h),

            /// Employee chips for New tab
            if (status == 0) ...[
              Row(
                children: [
                  buildReusableIconText(
                    kSecondaryLight.withOpacity(0.3),
                    Icons.work_outline,
                    "Emp#001",
                    kSecondary,
                  ),
                  SizedBox(width: 10.w),
                  buildReusableIconText(
                    kSecondaryLight.withOpacity(0.3),
                    Icons.work_outline,
                    "Emp#002",
                    kSecondary,
                  ),
                ],
              ),
              SizedBox(height: 12.h),
            ],

            /// BOTTOM SECTION - Full width buttons
            Container(
              width: double.infinity,
              child: _buildActionButtons(status),
            ),
            // SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  /// Builds status widget based on tab
  Widget _buildStatusWidget(int status) {
    switch (status) {
      case 0: // New
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildCircle(kSuccess, Appimages.rightIcon),
            // SizedBox(height: 1.h),
            buildCircle(kPrimary, Appimages.wrongIcon),
          ],
        );

      case 1: // Ongoing
        return Container(
          height: 24.h,
          width: 77.w,
          decoration: BoxDecoration(
            color: const Color(0xffFFF9D1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Center(
            child: Text(
              "At Job",
              style: appStyle(12.sp, kGrey400, FontWeight.w400),
            ),
          ),
        );

      case 2: // Completed
        return Container(
          height: 24.h,
          width: MediaQuery.of(context).size.width * 0.29,
          decoration: BoxDecoration(
            color: const Color(0xffE8FBE2),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Appimages.rightIcon, height: 14.h),
              SizedBox(width: 4.w),
              Text(
                "Completed",
                style: appStyle(11.sp, kSuccess, FontWeight.bold),
              ),
            ],
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }

  /// Builds action buttons based on status
  Widget _buildActionButtons(int status) {
    switch (status) {
      case 0: // New
        return userType == "Provider" && kycType == "Company"
            ? CircularButton(
                buttonColor: kPrimary,
                buttonText: "Assign Employee",
                onPressed: () {},
                height: 36.h,
                width: double.infinity,
                textSize: 14.sp,
              )
            : SizedBox();

      case 1: // Ongoing
        return Row(
          children: [
            Expanded(
              child: CustomOutlineButton(
                title: "Start",
                onPressed: () {},
                isFullWidth: true,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: CustomOutlineButton(
                title: "Navigate",
                onPressed: () {},
                isFullWidth: true,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: CustomOutlineButton(
                title: "Complete",
                onPressed: () {},
                isFullWidth: true,
              ),
            ),
          ],
        );

      case 2: // Completed
        return Row(
          children: [
            Expanded(
              child: CustomOutlineButton(
                title: "View Invoice",
                onPressed: () => Get.to(() => JobInvoiceDetailScreen()),
                isFullWidth: true,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: CustomOutlineButton(
                title: "Issue Report",
                onPressed: () => Get.to(() => ReportJobScreen()),
                isFullWidth: true,
              ),
            ),
          ],
        );

      default:
        return const SizedBox.shrink();
    }
  }

  Widget buildCircle(Color color, String image) {
    return Container(
      height: 29.h,
      width: 29.w,
      decoration: BoxDecoration(
        color: kWhite,
        shape: BoxShape.circle,
        border: Border.all(color: color),
      ),
      child: Center(child: Image.asset(image)),
    );
  }

  Widget buildReusableIconText(
    Color bgColor,
    IconData iconName,
    String title,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(iconName, size: 12.sp, color: color),
          SizedBox(width: 4.w),
          Flexible(
            child: Text(
              title,
              style: TextStyle(fontSize: 12.sp, color: color),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomOutlineButton extends StatelessWidget {
  const CustomOutlineButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isFullWidth = false,
  });

  final String title;
  final void Function()? onPressed;
  final bool isFullWidth;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: kPrimary),
        foregroundColor: kGrey400,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        minimumSize: isFullWidth ? Size(double.infinity, 36.h) : Size(0, 36.h),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(fontSize: 12.sp),
        textAlign: TextAlign.center,
      ),
    );
  }
}
