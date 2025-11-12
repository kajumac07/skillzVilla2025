import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_divider.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/screens/userSide/payMode/paymode_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddMoreServices extends StatefulWidget {
  const AddMoreServices({super.key});

  @override
  State<AddMoreServices> createState() => _AddMoreServicesState();
}

class _AddMoreServicesState extends State<AddMoreServices> {
  late List<Map<String, String>> _dates;
  final List<String> _timeSlots = [
    "9:00 AM",
    "10:00 AM",
    "11:00 AM",
    "12:00 PM",
    "1:00 PM",
    "2:00 PM",
    "3:00 PM",
    "4:00 PM",
    "5:00 PM",
    "6:00 PM",
    "7:00 PM",
    "8:00 PM",
    "9:00 PM",
  ];

  int selectedDateIndex = 0;
  int selectedTimeIndex = -1;

  @override
  void initState() {
    super.initState();
    _generateNextTenDates();
  }

  /// Generate dates dynamically from today → next 10 days
  void _generateNextTenDates() {
    final today = DateTime.now();
    _dates = List.generate(10, (i) {
      final date = today.add(Duration(days: i));
      return {
        "day": DateFormat('dd MMM').format(date),
        "weekday": DateFormat('EEE').format(date),
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add More Services',
          style: appStyle(18.sp, k232323, FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //now cart items will be shown here
            Container(
              height: 94.h,
              width: width,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(12.r),
              ),
              margin: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              child: Row(
                children: [
                  //image section
                  Image.asset(
                    Appimages.cartComponent,
                    height: 68.h,
                    width: 68.w,
                  ),
                  SizedBox(width: 5.w),
                  //title and duration and minute
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        label: "AC Repair & Maintenance",
                        size: 14,
                        color: kGrey300,
                      ),
                      SizedBox(height: 2.h),
                      CustomText(
                        label: "Duration: 40-50 mins ",
                        size: 12,
                        color: kGrey200,
                      ),
                      SizedBox(height: 4.h),

                      //time
                      Row(
                        children: [
                          Icon(
                            Icons.timelapse_sharp,
                            size: 14.sp,
                            color: kGreenAccent,
                          ),
                          Text(
                            "20 MINS",
                            style: appStyle(10.sp, kGrey300, FontWeight.w200),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  //price and qty section
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 26.h,
                        width: 60.w,
                        decoration: BoxDecoration(
                          color: kPrimary,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, size: 16.sp, color: kWhite),
                            SizedBox(width: 6.w),
                            CustomText(label: "1", size: 12.sp, color: kWhite),
                            SizedBox(width: 6.w),
                            Icon(Icons.remove, size: 16.sp, color: kWhite),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(),
                          SizedBox(width: 25.w),
                          CustomText(
                            label: "₹500",
                            size: 12.sp,
                            color: k232323,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            //------- Bill details section ---------
            Container(
              height: 170.h,
              width: width,
              // margin: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
              margin: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      label: "Bill Details",
                      size: 16.sp,
                      color: kGrey400,
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        CustomText(
                          label: "AC Cleaning",
                          size: 14.sp,
                          color: kGrey200,
                        ),
                        Spacer(),
                        CustomText(label: "₹500", size: 14.sp, color: kGrey200),
                      ],
                    ),

                    SizedBox(height: 5.h),
                    Row(
                      children: [
                        CustomText(
                          label: "Discount",
                          size: 14.sp,
                          color: kGrey200,
                        ),
                        Spacer(),
                        CustomText(label: "₹2", size: 14.sp, color: kGrey200),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    CustomText(
                      label: "Offer applied to your amount",
                      size: 10.sp,
                      color: kPrimary,
                    ),
                    SizedBox(height: 5.h),
                    CustomDivider(),
                    Row(
                      children: [
                        CustomText(
                          label: "Grand Total",
                          size: 16.sp,
                          color: k232323,
                          fontWeight: FontWeight.w600,
                        ),
                        Spacer(),
                        CustomText(
                          label: "₹498",
                          size: 16.sp,
                          color: k232323,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            /// ------------------ Address Section ------------------
            Container(
              height: 140.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(12.r),
              ),
              margin: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 75.w,
                          height: 32.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: kGreenAccent),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Center(
                            child: Text(
                              "Home",
                              style: appStyle(
                                14.sp,
                                kGreenAccent,
                                FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        CustomText(
                          label: "(default)",
                          size: 12.sp,
                          color: kGrey200,
                        ),
                        const Spacer(),
                        CustomText(
                          label: "Change",
                          size: 12.sp,
                          color: kPrimary,
                        ),
                      ],
                    ),
                    SizedBox(height: 3.h),
                    CustomText(
                      label: "Rahul Sharma",
                      size: 16.sp,
                      color: kGrey300,
                      fontWeight: FontWeight.w500,
                    ),
                    Text(
                      "#454, ABC Colony, Noida, Uttar Pradesh\n Uttar Pradesh, 252611\n Mobile: +91 9876543210",
                      style: appStyle(14.sp, kGrey200, FontWeight.w300),
                    ),
                  ],
                ),
              ),
            ),

            //date and time
            Container(
              margin: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 7.h),

                  /// ------------------ Date Selection ------------------
                  CustomText(
                    label: "Schedule Time and Date",
                    size: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: k232323,
                  ),
                  // SizedBox(height: 4.h),
                  CustomDivider(),
                  SizedBox(height: 10.h),
                  CustomText(
                    label: "Date",
                    size: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: k232323,
                  ),
                  SizedBox(height: 5.h),

                  SizedBox(
                    height: 70.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _dates.length,
                      itemBuilder: (context, index) {
                        final date = _dates[index];
                        final isSelected = selectedDateIndex == index;

                        return Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedDateIndex = index;
                                selectedTimeIndex = -1;
                              });
                            },
                            child: Container(
                              width: 65.w,
                              decoration: BoxDecoration(
                                color: isSelected ? kDAFAFF : Color(0xffF3F4F9),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                      left: 10.w,
                                      right: 10.w,
                                      top: 1.h,
                                      bottom: 1.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected ? kSecondary : kWhite,
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Text(
                                      date['weekday']!,
                                      style: appStyle(
                                        14.sp,
                                        kGrey300,
                                        FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    date['day']!,
                                    style: appStyle(
                                      12.sp,
                                      k232323,
                                      FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 20.h),

                  /// ------------------ Time Selection ------------------
                  CustomText(
                    label: "Time",
                    size: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: k232323,
                  ),
                  SizedBox(height: 10.h),

                  Wrap(
                    spacing: 10.w,
                    runSpacing: 10.h,
                    children: List.generate(_timeSlots.length, (index) {
                      final time = _timeSlots[index];
                      final isSelected = selectedTimeIndex == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTimeIndex = index;
                          });
                        },
                        child: Container(
                          width: (width - 80.w) / 4.5, // 4 per row
                          height: 35.h,
                          decoration: BoxDecoration(
                            color: isSelected ? kSecondary : Color(0xffF3F4F9),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            time,
                            style: appStyle(
                              13.sp,
                              isSelected ? kWhite : kGrey400,
                              FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),

            //proceed top checkout
            Container(
              margin: EdgeInsets.only(top: 16.h, left: 10.w, right: 10.w),
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              child: CircularButton(
                buttonColor: kPrimary,
                buttonText: "Procees to Checkout",
                onPressed: () => Get.to(() => PayModeScreen()),
                width: 1.sw,
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
