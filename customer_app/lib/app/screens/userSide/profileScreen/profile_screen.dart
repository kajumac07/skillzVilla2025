import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/widgets/custom_divider.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/global/widgets/icon_tap_image.dart';
import 'package:customer_app/app/screens/notifications/notification_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kWhite,
        scrolledUnderElevation: 0,
        title: Text(
          'Profile',
          style: appStyle(18.sp, k232323, FontWeight.w600),
        ),
        actions: [
          TapImageIcon(
            imageName: Appimages.notiIcon,
            onTap: () => Get.to(() => NotificationScreens()),
          ),
          SizedBox(width: 10.w),
          TapImageIcon(imageName: Appimages.editIcon, onTap: () {}),
          SizedBox(width: 10.w),
        ],
      ),

      body: Column(
        children: [
          //top Profile Section
          // Container(
          //   height: 224.h,
          //   width: width,
          //   decoration: BoxDecoration(color: kPrimary),
          // ),

          //Your Information
          Container(
            width: width,
            margin: EdgeInsets.all(12.h),
            padding: EdgeInsets.all(12.h),
            decoration: BoxDecoration(color: kWhite),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //heading section
                CustomText(
                  label: "Your Information",
                  size: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
                CustomDivider(),
                ListTileOptions(
                  imageName: Appimages.pStar,
                  title: 'My Ratings & Reviews',
                ),
                ListTileOptions(
                  imageName: Appimages.mapIcon,
                  title: 'Manage Address',
                ),
                ListTileOptions(
                  imageName: Appimages.pSetting,
                  title: 'Manage Address',
                ),
                ListTileOptions(imageName: Appimages.pDoc, title: 'Documents'),
              ],
            ),
          ),

          //More
          Container(
            width: width,
            margin: EdgeInsets.all(12.h),
            padding: EdgeInsets.all(12.h),
            decoration: BoxDecoration(color: kWhite),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //heading section
                CustomText(
                  label: "More",
                  size: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
                CustomDivider(),
                ListTileOptions(
                  imageName: Appimages.aSkilzVilla,
                  title: 'About SkillzVilla',
                ),
                ListTileOptions(imageName: Appimages.faq, title: 'FAQ'),
                ListTileOptions(
                  imageName: Appimages.policies,
                  title: 'Policies',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ListTileOptions extends StatelessWidget {
  const ListTileOptions({
    super.key,
    required this.imageName,
    required this.title,
  });
  final String imageName;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        imageName,
        height: 24.h,
        width: 24.w,
        color: kSecondary,
      ),
      title: CustomText(
        label: title,
        size: 16.sp,
        color: kGrey300,
        fontWeight: FontWeight.w500,
      ),
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}
