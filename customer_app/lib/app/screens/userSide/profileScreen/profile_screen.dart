import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/widgets/custom_divider.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/global/widgets/icon_tap_image.dart';
import 'package:customer_app/app/global/widgets/list_tile_options.dart';
import 'package:customer_app/app/screens/notifications/notification_screens.dart';
import 'package:customer_app/app/screens/userSide/coupons/coupons_screens.dart';
import 'package:customer_app/app/screens/userSide/profileScreen/widgets/profile_address_screen.dart';
import 'package:customer_app/app/screens/userSide/profileScreen/widgets/profile_settings_screen.dart';
import 'package:customer_app/app/screens/userSide/wallets/wallet_screen.dart';
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
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.circular(8.r),
            ),
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
                  onTap: () {},
                ),
                ListTileOptions(
                  imageName: Appimages.mapIcon,
                  title: 'Manage Address',
                  onTap: () => Get.to(() => ManageProfileAddressscreens()),
                ),
                ListTileOptions(
                  imageName: Appimages.pSetting,
                  title: 'Settings',
                  onTap: () => Get.to(() => ProfileSettingsScreen()),
                ),
                ListTileOptions(
                  imageName: Appimages.pDoc,
                  title: 'Documents',
                  onTap: () => Get.to(() => CouponsScreens()),
                ),
                ListTileOptions(
                  imageName: Appimages.pDoc,
                  title: 'Wallet',
                  onTap: () => Get.to(() => WalletScreen()),
                ),
              ],
            ),
          ),

          //More
          Container(
            width: width,
            margin: EdgeInsets.all(12.h),
            padding: EdgeInsets.all(12.h),
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.circular(8.r),
            ),
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
                  onTap: () {},
                ),
                ListTileOptions(
                  imageName: Appimages.faq,
                  title: 'FAQ',
                  onTap: () {},
                ),
                ListTileOptions(
                  imageName: Appimages.policies,
                  title: 'Policies',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
