import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_divider.dart';
import 'package:customer_app/app/screens/userSide/myBookings/widgets/scheduled_booking.dart';
import 'package:customer_app/app/screens/userSide/myBookings/widgets/track_my_bookings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kWhite,
          scrolledUnderElevation: 0,
          title: Text(
            'My Bookings',
            style: appStyle(18.sp, k232323, FontWeight.w600),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48.h),
            child: Container(
              // margin: EdgeInsets.symmetric(horizontal: 16.w),
              child: TabBar(
                labelColor: kDark,
                unselectedLabelColor: kGrey200,
                indicatorColor: kPrimary,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 2.5,
                labelStyle: appStyle(14.sp, kGrey400, FontWeight.w600),
                unselectedLabelStyle: appStyle(
                  14.sp,
                  kGrey200,
                  FontWeight.w400,
                ),
                tabs: const [
                  Tab(text: 'Ongoing'),
                  Tab(text: 'Scheduled'),
                  Tab(text: 'Completed'),
                ],
              ),
            ),
          ),
        ),

        body: TabBarView(
          children: [
            _buildBookingList(BookingStatus.ongoing),
            _buildBookingList(BookingStatus.scheduled),
            _buildBookingList(BookingStatus.completed),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingList(BookingStatus status) {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30.r),
                    child: Image.asset(
                      Appimages.laptopService,
                      width: 45.w,
                      height: 45.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Laptop Service',
                          style: appStyle(14.sp, kGrey400, FontWeight.bold),
                        ),
                        Text(
                          'Rachel Green, Perfect Cleaners',
                          style: appStyle(12.sp, kGrey200, FontWeight.w400),
                        ),
                        Text(
                          'ID - #345678',
                          style: appStyle(10.sp, kGrey200, FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '15 Oct, 2025',
                        style: appStyle(14.sp, kGrey400, FontWeight.w500),
                      ),
                      Text(
                        '2.30 PM',
                        style: appStyle(12.sp, kGrey400, FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              CustomDivider(),
              SizedBox(height: 6.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width * 0.44,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          Appimages.mapIcon,
                          width: 20.w,
                          height: 20.w,
                        ),
                        // SizedBox(width: 4.w),
                        Text(
                          '123 Main Street, India',
                          maxLines: 2,
                          style: appStyle(14.sp, kGrey200, FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // color: kRed,
                    width: width * 0.32,
                    child: Text(
                      'Booking ID - #212345',
                      style: appStyle(12.sp, kGrey200, FontWeight.w400),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              if (status == BookingStatus.ongoing) ...[
                //show this button only for ongoing bookings
                CircularButton(
                  buttonColor: kPrimary,
                  buttonText: "Track",
                  onPressed: () => Get.to(
                    () => TrackMyBookingsScren(
                      title: "Laptop Service",
                      img: Appimages.laptopService,
                      status: BookingStatus.ongoing,
                    ),
                  ),
                  width: width,
                  height: 40.h,
                ),
              ] else if (status == BookingStatus.scheduled) ...[
                //show this button only for Scheduled bookings
                Row(
                  children: [
                    Expanded(
                      child: CircularButton(
                        buttonColor: kPrimary,
                        buttonText: "Reschedule",
                        onPressed: () => Get.to(() => CustomerBookingsScreen()),
                        height: 40.h,
                      ),
                    ),
                    SizedBox(width: 10.h),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.to(
                          () => TrackMyBookingsScren(
                            title: "Laptop Service",
                            img: Appimages.laptopService,
                            status: BookingStatus.scheduled,
                          ),
                        ),

                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: kGrey100),
                          minimumSize: Size(double.infinity, 42.h),
                          foregroundColor: kGrey300,
                        ),
                        child: Text("Cancel"),
                      ),
                    ),
                  ],
                ),
              ] else if (status == BookingStatus.completed) ...[
                //show this button only for Completed bookings
                CircularButton(
                  buttonColor: kPrimary,
                  buttonText: "Book Again",
                  onPressed: () {},
                  width: width,
                  height: 40.h,
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

enum BookingStatus { ongoing, scheduled, completed }
