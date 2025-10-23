import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// --- Dummy Data Structure ---
class NotificationItem {
  final String title;
  final String message;
  final String time;
  final String imagePath;

  NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.imagePath,
  });
}

// --- Dummy Data ---
final List<NotificationItem> todayNotifications = [
  NotificationItem(
    title: '123, Green Avenue',
    message:
        'Lorem ipsum has been the industry\'s standard dummy text ever since the 1500s',
    time: 'Just Now',
    imagePath: Appimages.providerIcon,
  ),
  NotificationItem(
    title: '123, Green Avenue',
    message:
        'Lorem ipsum has been the industry\'s standard dummy text ever since the 1500s',
    time: '5:00 AM',
    imagePath: Appimages.providerIcon,
  ),
  NotificationItem(
    title: '123, Green Avenue',
    message:
        'Lorem ipsum has been the industry\'s standard dummy text ever since the 1500s',
    time: '5:00 AM',
    imagePath: Appimages.providerIcon,
  ),
  NotificationItem(
    title: '123, Green Avenue',
    message:
        'Lorem ipsum has been the industry\'s standard dummy text ever since the 1500s',
    time: '5:00 AM',
    imagePath: Appimages.providerIcon,
  ),
];

final List<NotificationItem> pastMonthNotifications = [
  NotificationItem(
    title: '123, Green Avenue',
    message:
        'Lorem ipsum has been the industry\'s standard dummy text ever since the 1500s',
    time: '22 Aug, 5:00 AM',
    imagePath: Appimages.providerIcon,
  ),
  NotificationItem(
    title: '123, Green Avenue',
    message:
        'Lorem ipsum has been the industry\'s standard dummy text ever since the 1500s',
    time: '22 Aug, 5:00 AM',
    imagePath: Appimages.providerIcon,
  ),
  NotificationItem(
    title: '123, Green Avenue',
    message:
        'Lorem ipsum has been the industry\'s standard dummy text ever since the 1500s',
    time: '22 Aug, 5:00 AM',
    imagePath: Appimages.providerIcon,
  ),
  NotificationItem(
    title: '123, Green Avenue',
    message:
        'Lorem ipsum has been the industry\'s standard dummy text ever since the 1500s',
    time: '22 Aug, 5:00 AM',
    imagePath: Appimages.providerIcon,
  ),
  NotificationItem(
    title: '123, Green Avenue',
    message:
        'Lorem ipsum has been the industry\'s standard dummy text ever since the 1500s',
    time: '5:00 AM',
    imagePath: Appimages.providerIcon,
  ),
];

class NotificationScreens extends StatelessWidget {
  const NotificationScreens({super.key});

  Widget _buildNotificationTile(
    NotificationItem item, {
    bool isJustNow = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Avatar (Image)
          CircleAvatar(
            radius: 25.r,
            backgroundColor: kWhite,
            child: Image.asset(item.imagePath),
          ),
          SizedBox(width: 12.w),
          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: appStyle(14.sp, kSecondary, FontWeight.w600),
                ),
                SizedBox(height: 2.h),
                Text(
                  item.message,
                  style: appStyle(12.sp, k232323, FontWeight.w400),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          // Time/Status
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 40.h),
              Text(
                item.time,
                style: appStyle(
                  12.sp,
                  isJustNow ? kSecondary : kGrey200,
                  FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // A helper widget for the Today notifications section
  Widget _buildTodaySection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Color(0xffFFDDD3)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: todayNotifications.length,
        separatorBuilder: (context, index) => SizedBox(height: 8.h),
        itemBuilder: (context, index) {
          return _buildNotificationTile(
            todayNotifications[index],
            isJustNow: index == 0,
          );
        },
      ),
    );
  }

  // A helper widget for the Past Month notifications section
  Widget _buildPastMonthSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(10.r),
        // border: Border.all(color: kPrimary),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: pastMonthNotifications.length,
        separatorBuilder: (context, index) => SizedBox(height: 8.h),
        itemBuilder: (context, index) {
          return _buildNotificationTile(pastMonthNotifications[index]);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kWhite,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: k232323, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Notifications',
          style: appStyle(18.sp, k232323, FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Today Section Header ---
            Padding(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                top: 24.h,
                bottom: 8.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Today',
                    style: appStyle(16.sp, k232323, FontWeight.w600),
                  ),
                  Text(
                    'Clear all',
                    style: appStyle(14.sp, kGrey200, FontWeight.w500),
                  ),
                ],
              ),
            ),

            // --- Today Notifications Box ---
            _buildTodaySection(),

            // --- Past Month Section Header ---
            Padding(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                top: 24.h,
                bottom: 8.h,
              ),
              child: Text(
                'Past Month',
                style: appStyle(16.sp, k232323, FontWeight.w600),
              ),
            ),

            // --- Past Month Notifications Box ---
            _buildPastMonthSection(),

            SizedBox(height: 20.h), // Bottom padding
          ],
        ),
      ),
    );
  }
}
