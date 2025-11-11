import 'dart:developer';

import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_divider.dart';
import 'package:customer_app/app/screens/userSide/myBookings/my_bookings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrackMyBookingsScren extends StatefulWidget {
  const TrackMyBookingsScren({
    super.key,
    required this.title,
    required this.img,
    required this.status,
  });
  final String title;
  final String img;
  final BookingStatus status;

  @override
  State<TrackMyBookingsScren> createState() => _TrackMyBookingsScrenState();
}

class _TrackMyBookingsScrenState extends State<TrackMyBookingsScren> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Booking Details',
          style: appStyle(18.sp, k232323, FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          //top part
          Container(
            height: 90.h,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.r),
                  child: Image.asset(
                    widget.img,
                    width: 60.w,
                    height: 60.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.title,
                      style: appStyle(18.sp, kGrey400, FontWeight.bold),
                    ),
                    Text(
                      "Perfect Laptop Service",
                      style: appStyle(15.sp, kGrey200, FontWeight.w400),
                    ),
                  ],
                ),
                Spacer(),

                widget.status == BookingStatus.ongoing
                    ? Container(
                        height: 24.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                          color: kSuccess.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Center(
                          child: Text(
                            "30 minutes",
                            style: appStyle(12.sp, kSuccess, FontWeight.w500),
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),

          widget.status == BookingStatus.ongoing
              ? buildOngoingBookingDetails()
              : buildCancellationBookingDetails(),
        ],
      ),
    );
  }

  Widget buildOngoingBookingDetails() {
    return Container(
      width: width,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          buildRowText("Date & Time", "22 Aug , 2025 | 10:00 AM", false),
          SizedBox(height: 10.h),
          CustomDivider(),
          buildRowText("Booking ID", "#212345", false),
          SizedBox(height: 10.h),
          CustomDivider(),
          buildRowText("Price", "₹2000", false),
          SizedBox(height: 10.h),
          CustomDivider(),
          buildRowText("Address", "123 Main Street, India", true),
          SizedBox(height: 10.h),
          //image section
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(12.r),
            child: Image.asset(
              Appimages.bookingMap,
              height: 250.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          //buttons
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    log("Whatsapp Button Tapped");
                  },
                  child: Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: kPrimary,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(Appimages.whatsappIcon),
                        SizedBox(width: 5.w),
                        Text(
                          "Whatsapp",
                          style: appStyle(14.sp, kWhite, FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.h),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: kGrey100),
                    minimumSize: Size(double.infinity, 42.h),
                    foregroundColor: kGrey300,
                  ),
                  child: Text("Need Help?"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //build row text
  Widget buildRowText(String firstText, String secondText, bool isAddress) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(firstText, style: appStyle(14.sp, kGrey300, FontWeight.w400)),
        Row(
          children: [
            isAddress
                ? Image.asset(Appimages.mapIcon, width: 12.w, height: 12.h)
                : SizedBox(),
            Text(secondText, style: appStyle(14.sp, kGrey200, FontWeight.w400)),
          ],
        ),
      ],
    );
  }

  Widget buildCancellationBookingDetails() {
    String? selectedReason;

    List<String> cancelReasons = [
      "Change of plans",
      "Booked by mistake",
      "Found a better price",
      "Service not needed",
      "Other",
    ];

    return Container(
      width: width,
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildRowTextAndIcon(Appimages.bookingTime, "09:00 AM - 10:00 AM"),
          SizedBox(height: 5.h),
          CustomDivider(),
          buildRowTextAndIcon(Appimages.bookingCalendar, "Thursday, Oct 13"),
          SizedBox(height: 5.h),
          CustomDivider(),
          buildRowTextAndIcon(Appimages.bookingLoc, "123 Main Street, India"),
          SizedBox(height: 5.h),
          CustomDivider(),
          buildRowTextAndIcon(Appimages.bookingProfile, "SkilzVilla"),
          SizedBox(height: 15.h),
          StatefulBuilder(
            builder: (context, setState) {
              return Container(
                height: 40.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.r),
                  border: Border.all(
                    color: Colors.grey.shade400, // subtle grey border
                    width: 1,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedReason,
                    isExpanded: true,
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.grey.shade600,
                    ),
                    hint: Text(
                      "Reason for Cancellation",
                      style: appStyle(
                        15.sp,
                        Colors.grey.shade600,
                        FontWeight.w400,
                      ),
                    ),
                    items: cancelReasons.map((reason) {
                      return DropdownMenuItem(
                        value: reason,
                        child: Text(
                          reason,
                          style: appStyle(
                            15.sp,
                            Colors.grey.shade800,
                            FontWeight.w400,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedReason = value;
                      });
                    },
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 8.h),

          CircularButton(
            buttonColor: kPrimary,
            buttonText: "Cancel Booking",
            onPressed: () {
              if (selectedReason == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Please select a reason first")),
                );
              } else {}
            },
            width: double.infinity,
            height: 42.h,
          ),
        ],
      ),
    );
  }

  Widget buildRowTextAndIcon(String imageName, String title) {
    return Row(
      children: [
        Image.asset(imageName, height: 24.h, width: 24.w),
        SizedBox(width: 20.w),
        Text(title, style: appStyle(14.sp, kGrey300, FontWeight.w300)),
      ],
    );
  }
}
