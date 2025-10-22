import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/screens/userSide/payMode/paymode_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // 👈 for date formatting

class AddressAndSchedule extends StatefulWidget {
  const AddressAndSchedule({super.key});

  @override
  State<AddressAndSchedule> createState() => _AddressAndScheduleState();
}

class _AddressAndScheduleState extends State<AddressAndSchedule> {
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
        "day": DateFormat('dd MMM').format(date), // e.g. "21 Oct"
        "weekday": DateFormat('EEE').format(date), // e.g. "Mon"
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          builTopSection(context),

          // Main Content
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// ------------------ Address Section ------------------
                    Container(
                      height: 140.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
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
                            SizedBox(height: 10.h),
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

                    SizedBox(height: 20.h),

                    /// ------------------ Date Selection ------------------
                    CustomText(
                      label: "Select Date",
                      size: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: k232323,
                    ),
                    SizedBox(height: 10.h),

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
                                  color: isSelected ? kDAFAFF : kWhite,
                                  // border: Border.all(
                                  //   color: isSelected ? kDAFAFF : kDAFAFF,
                                  // ),
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
                                        color: isSelected
                                            ? kSecondary
                                            : kE9E9E9,
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
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
                      label: "Select Time",
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
                            width: (width - 80.w) / 4, // 4 per row
                            height: 35.h,
                            decoration: BoxDecoration(
                              color: isSelected ? kSecondary : kWhite,
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularButton(
          buttonColor: kPrimary,
          buttonText: "Procees to checkout",
          onPressed: () => Get.to(() => PayModeScreen()),
        ),
      ),
    );
  }

  Widget builTopSection(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Stack(
        children: [
          Image(
            image: AssetImage(Appimages.locationBgImage),
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Positioned(
            top: 50,
            left: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(Icons.arrow_back_ios, size: 20.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
