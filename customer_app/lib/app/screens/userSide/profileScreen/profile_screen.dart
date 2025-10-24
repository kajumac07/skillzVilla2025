import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/widgets/custom_divider.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/global/widgets/icon_tap_image.dart';
import 'package:customer_app/app/global/widgets/list_tile_options.dart';
import 'package:customer_app/app/screens/notifications/notification_screens.dart';
import 'package:customer_app/app/screens/userSide/coupons/coupons_screens.dart';
import 'package:customer_app/app/screens/userSide/profileScreen/widgets/my_reviews_nd_rating.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            //top Profile Section
            // Container(
            //   height: 224.h,
            //   width: width,
            //   margin: EdgeInsets.all(12),
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage(Appimages.profileBg),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),

            // Top Profile Section with overlapping card
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Background image
                Container(
                  height: 224.h,
                  width: width,
                  margin: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Appimages.profileBg),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),

                // Overlapping Card
                Positioned(
                  bottom: -50.h, // controls how much overlaps
                  left: 16.w,
                  right: 16.w,
                  child: Container(
                    height: 80.h,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: kPrimaryLight,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildProfileOption(
                          image: Appimages.walletIcon,
                          title: 'Wallet',
                          onTap: () => Get.to(() => WalletScreen()),
                        ),
                        _buildProfileOption(
                          image: Appimages.privacy,
                          title: 'My Bookings',
                          onTap: () {},
                        ),
                        _buildProfileOption(
                          image: Appimages.helpCenter,
                          title: 'Help & Support',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 70.h),

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
                    onTap: () => Get.to(() => MyReviewsNdRatingScreen()),
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
      ),
    );
  }

  Widget _buildProfileOption({
    required String image,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 24.h, width: 24.w),
          SizedBox(height: 4.h),
          CustomText(
            label: title,
            size: 12.sp,
            fontWeight: FontWeight.w500,
            color: kGrey400,
          ),
        ],
      ),
    );
  }
}
