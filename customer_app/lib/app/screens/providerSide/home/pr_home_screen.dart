import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/global/widgets/fourty_two_circle_icon.dart';
import 'package:customer_app/app/screens/providerSide/kyc/kyc_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProviderHomeScreen extends StatefulWidget {
  const ProviderHomeScreen({super.key});

  @override
  State<ProviderHomeScreen> createState() => _ProviderHomeScreenState();
}

class _ProviderHomeScreenState extends State<ProviderHomeScreen> {
  final List<Map<String, dynamic>> dummyBookings = [
    {
      "service": "Deep Cleaning",
      "client": "Rahul Sharma",
      "status": "Completed",
      "color": kSuccess,
      "icon": Icons.check,
      "bgColor": Color(0xffECECEF),
    },
    {
      "service": "AC Repair",
      "client": "Amit Verma",
      "status": "Ongoing",
      "color": kSecondary,
      "icon": Icons.timelapse,
      "bgColor": Color(0xffECECEF),
    },
    {
      "service": "Car Wash",
      "client": "Neha Kapoor",
      "status": "Pending",
      "color": Color(0xffFCBA2B),
      "icon": Icons.calendar_month,
      "bgColor": kSecondary,
    },
    {
      "service": "Home Painting",
      "client": "Priya Mehta",
      "status": "Cancelled",
      "color": kPrimary,
      "icon": Icons.cancel,
      "bgColor": Color(0xffECECEF),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //top card
            buildTopHeader(context),
            //Plan Status
            Padding(
              padding: EdgeInsets.all(8.0.h),
              child: CustomText(
                label: "Plan Status",
                size: 16.sp,
                color: kGrey400,
                fontWeight: FontWeight.bold,
              ),
            ),

            //status card
            buildBannerCard(),
            SizedBox(height: 2.h),
            //latest 5 bookings
            Padding(
              padding: EdgeInsets.all(8.0.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    label: "Latest 5 Bookings",
                    size: 16.sp,
                    color: kGrey400,
                    fontWeight: FontWeight.w400,
                  ),
                  CustomText(
                    label: "View All",
                    size: 10.sp,
                    color: kGrey300,
                    fontWeight: FontWeight.w100,
                  ),
                ],
              ),
            ),
            //latest booking lists
            Column(
              children: dummyBookings.map((booking) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: LatestBookingLists(
                    serviceName: booking["service"],
                    clientName: booking["client"],
                    status: booking["status"],
                    color: booking["color"],
                    icon: booking["icon"],
                    bgColor: booking["bgColor"],
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularButton(
                buttonColor: kPrimary,
                buttonText: "Manage Services",
                onPressed: () {},
                width: width,
                height: 42.h,
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  // build Banner Card with Slider
  Widget buildBannerCard() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 5.h),
          child: SizedBox(
            height: 186.h,
            width: width,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 2.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22.r),
                color: kWhite,
                // image: DecorationImage(
                //   image: AssetImage(Appimages.prBg),
                //   fit: BoxFit.cover,
                // ),
                boxShadow: [BoxShadow(color: kPrimaryLight, blurRadius: 5)],
              ),
              clipBehavior: Clip.hardEdge,
              child: Stack(
                children: [
                  // Girl image (on right)
                  Positioned(
                    right: 25.w,
                    bottom: 15.h,
                    child: Image.asset(
                      Appimages.prBanner,
                      height: 150.h,
                      width: 150.w,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Text content (on left)
                  Positioned(
                    left: 20.w,
                    top: 0,
                    bottom: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "EXISTING SERVICE PLAN",
                          style: appStyle(10.sp, kGrey300, FontWeight.normal),
                        ),
                        ShaderMask(
                          shaderCallback: (bounds) {
                            return const LinearGradient(
                              colors: [Color(0xffD05506), Color(0xffA93B30)],
                            ).createShader(bounds);
                          },
                          child: Text(
                            "PREMIUM",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          height: 24.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xffC5923F), Color(0xff99613D)],
                            ),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Center(
                            child: CustomText(
                              label: "Upgrade",
                              color: kWhite,
                              size: 12,
                            ),
                          ),
                        ),

                        SizedBox(height: 8.h),
                        Text(
                          "Expiring on 30Sept25",
                          style: appStyle(10, kGrey300, FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  //=========== Top Header ==================
  Widget buildTopHeader(context) {
    return Container(
      // height: 278.h,
      width: width,
      decoration: BoxDecoration(gradient: kHeaderLinear),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40.h),
            //top icon section
            Row(
              children: [
                GestureDetector(
                  onTap: () => Get.to(() => KycScreen()),
                  child: Image.asset(
                    Appimages.personIcon,
                    height: 42.h,
                    width: 42.w,
                  ),
                ),
                Spacer(),
                //indicator
                Container(
                  height: 14.h,
                  width: 14.w,
                  decoration: BoxDecoration(
                    color: kSuccess,
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                ),
                SizedBox(width: 10.w),
                FourtyTwoCircleIcon(
                  onTap: () {},
                  imageName: Appimages.notiIcon,
                ),
                SizedBox(width: 10.w),
                FourtyTwoCircleIcon(
                  onTap: () {},
                  imageName: Appimages.drawerIcon,
                ),
              ],
            ),
            SizedBox(height: 15.h),
            //heading
            CustomText(
              label: "Hi Rohan ! Check Insights",
              size: 18.sp,
              color: kGrey400,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 15.h),
            //Stats card
            Container(
              height: 140.h,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(color: kPrimary),
                gradient: LinearGradient(
                  colors: [
                    Color(0xffEBDC7C),
                    Color(0xffFFB17D),
                    Color(0xffE65E60),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: kGrey100,
                    blurRadius: 0.8,
                    spreadRadius: 0.10,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: buildStatsCard(
                      Appimages.jobIcon,
                      "120",
                      "Jobs Completed",
                      kSecondaryLight,
                    ),
                  ),
                  Expanded(
                    child: buildStatsCard(
                      Appimages.earnIcon,
                      "300",
                      "Earnings To-Date",
                      kPrimaryLight,
                    ),
                  ),
                  Expanded(
                    child: buildStatsCard(
                      Appimages.premiumIcon,
                      "30 days",
                      "Plan Premium",
                      kFFF9D1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //============ Stats Card ==================
  Widget buildStatsCard(
    String imageName,
    String count,
    String title,
    Color color,
  ) {
    return Container(
      margin: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(imageName, height: 24.h, width: 24.w),
            SizedBox(height: 8.h),
            CustomText(
              label: count,
              size: 15.sp,
              color: kGrey300,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 2.h),
            CustomText(
              label: title,
              size: 12.sp,
              color: kGrey200,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}

class LatestBookingLists extends StatelessWidget {
  const LatestBookingLists({
    super.key,
    required this.serviceName,
    required this.clientName,
    required this.status,
    required this.color,
    required this.icon,
    this.bgColor = const Color(0xffECECEF),
  });
  final String serviceName;
  final String clientName;
  final String status;
  final Color color;
  final IconData icon;
  final Color bgColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.h, right: 10.h, top: 5.h, bottom: 5.h),
      margin: EdgeInsets.only(left: 10.h, right: 10.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          height: 42.h,
          width: 42.w,
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(12.r),
            image: DecorationImage(image: AssetImage(Appimages.privacy)),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(label: serviceName, size: 16.sp, color: kGrey300),
            CustomText(label: clientName, size: 14.sp, color: kGrey200),
          ],
        ),
        trailing: Column(
          children: [
            CircleAvatar(
              radius: 18.r,
              backgroundColor: color,
              child: Icon(icon, color: kWhite),
            ),
            CustomText(label: status, size: 10.sp, color: kGrey200),
          ],
        ),
      ),
    );
  }
}
