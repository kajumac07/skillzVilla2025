import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BannerSlotsBookingScreen extends StatelessWidget {
  const BannerSlotsBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Banner Slots Booking",
          style: appStyle(18.sp, kGrey400, FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            BookingCard(
              status: BookingStatus.rejected,
              date: "22 Aug, 2025",
              duration: "3 hours",
              price: "₹1000",
              reasons: const [
                "Image size is not per standards",
                "Resolution too low for banner slot",
              ],
            ),
            SizedBox(height: 20.h),
            BookingCard(
              status: BookingStatus.approved,
              date: "30 Aug, 2025",
              duration: "6 hours",
              price: "₹1800",
            ),
          ],
        ),
      ),
    );
  }
}

enum BookingStatus { approved, rejected }

class BookingCard extends StatefulWidget {
  final BookingStatus status;
  final String date;
  final String duration;
  final String price;
  final List<String>? reasons;

  const BookingCard({
    super.key,
    required this.status,
    required this.date,
    required this.duration,
    required this.price,
    this.reasons,
  });

  @override
  State<BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  bool showReasons = false;

  @override
  Widget build(BuildContext context) {
    final bool isRejected = widget.status == BookingStatus.rejected;
    final Color badgeColor = isRejected
        ? const Color(0xffFFDADB)
        : const Color(0xffD8F7DD);
    final Color textColor = isRejected ? kPrimary : kSuccess;
    final String badgeText = isRejected
        ? "Request Rejected"
        : "Request Approved";
    final IconData badgeIcon = isRejected
        ? Icons.error
        : Icons.check_circle_outline;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// --- Badge ---
          Container(
            width: width,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: badgeColor,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(badgeIcon, color: textColor, size: 16),
                SizedBox(width: 6.w),
                Text(
                  badgeText,
                  style: appStyle(15.sp, textColor, FontWeight.w500),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          /// --- Booking Details ---
          Text(
            "Booking details",
            style: appStyle(18.sp, kGrey400, FontWeight.bold),
          ),
          SizedBox(height: 10.h),

          bookingInfoRow("Date", widget.date),
          bookingInfoRow("Duration", widget.duration),
          bookingInfoRow("Price Paid", widget.price),

          /// --- Banner Preview (if Approved) ---
          // if (!isRejected)
          //   Padding(
          //     padding: EdgeInsets.only(top: 8.h),
          //     child: CircularButton(
          //       buttonColor: kPrimary,
          //       buttonText: "View Banner Preview",
          //       onPressed: () {},
          //       height: 40.h,
          //       width: width,
          //       textSize: 14.sp,
          //     ),
          //   ),
          SizedBox(height: 12.h),
          CustomDivider(),

          /// --- Rejection Section (only for Rejected cards) ---
          if (isRejected) ...[
            InkWell(
              onTap: () => setState(() => showReasons = !showReasons),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Reasons for rejection –",
                      style: appStyle(16.sp, kGrey300, FontWeight.w500),
                    ),
                    Icon(
                      showReasons
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: kGrey400,
                    ),
                  ],
                ),
              ),
            ),
            if (showReasons)
              Padding(
                padding: EdgeInsets.only(left: 4.w, bottom: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: (widget.reasons ?? [])
                      .map(
                        (reason) => Padding(
                          padding: EdgeInsets.only(bottom: 6.h),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                size: 18.sp,
                                color: kGrey200,
                              ),
                              SizedBox(width: 6.w),
                              Expanded(
                                child: Text(
                                  reason,
                                  style: appStyle(
                                    14.sp,
                                    kGrey200,
                                    FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
          ],

          /// --- Bottom Button ---
          SizedBox(height: 8.h),
          CircularButton(
            buttonColor: isRejected ? kPrimary : kPrimary,
            buttonText: isRejected
                ? "Request Another Seat"
                : "View Banner Preview",
            onPressed: () {},
            height: 40.h,
            width: width,
            textSize: 15.sp,
          ),
        ],
      ),
    );
  }

  Widget bookingInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: appStyle(16.sp, kGrey200, FontWeight.w400)),
          Text(value, style: appStyle(16.sp, kGrey400, FontWeight.bold)),
        ],
      ),
    );
  }
}
