import 'dart:developer';

import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/services/shared_pref.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_divider.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/global/widgets/icon_tap_image.dart';
import 'package:customer_app/app/global/widgets/list_tile_options.dart';
import 'package:customer_app/app/screens/about/about_skilzvilla_screen.dart';
import 'package:customer_app/app/screens/faqs/faq_screen.dart';
import 'package:customer_app/app/screens/notifications/notification_screens.dart';
import 'package:customer_app/app/screens/policies/policies_screen.dart';
import 'package:customer_app/app/screens/userSide/coupons/coupons_screens.dart';
import 'package:customer_app/app/screens/userSide/profileScreen/editProfile/edit_profile_screen.dart';
import 'package:customer_app/app/screens/userSide/profileScreen/widgets/my_reviews_nd_rating.dart';
import 'package:customer_app/app/screens/userSide/profileScreen/widgets/profile_address_screen.dart';
import 'package:customer_app/app/screens/userSide/profileScreen/widgets/profile_settings_screen.dart';
import 'package:customer_app/app/screens/userSide/wallets/wallet_screen.dart';
import 'package:customer_app/app/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userType;
  String? kycType;
  String displayName = "Loading...";
  String displayNumber = "";
  final _sharedPref = AppSharedPrefData();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    userType = await _sharedPref.getUserType();
    kycType = await _sharedPref.getKycType();
    log("EditProfileScreen → userType: $userType | kycType: $kycType");

    if (userType == "Customer" && kycType == "Customer") {
      displayName = "Rahul Sharma";
      displayNumber = "9876543210";
    } else if (userType == "Provider" && kycType == "Freelance") {
      displayName = "John Doe";
      displayNumber = "9998887777";
    } else if (userType == "Provider" && kycType == "Company") {
      displayName = "XYZ Company";
      displayNumber = "778899002";
    } else {
      displayName = "Guest User";
      displayNumber = "N/A";
    }

    setState(() {});
  }

  Future<void> _logout() async {
    await _sharedPref.clearAll();
    Get.offAll(
      () => const WelcomeScreen(),
      transition: Transition.fadeIn,
      duration: const Duration(milliseconds: 500),
    );
  }

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
          TapImageIcon(
            imageName: Appimages.editIcon,
            onTap: () => Get.to(() => EditProfileScreen()),
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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

                Positioned(
                  bottom: 30.h,
                  left: 16.w,
                  right: 16.w,
                  child: Column(
                    children: [
                      CustomText(
                        label: displayName,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(label: displayNumber, size: 14.sp),
                    ],
                  ),
                ),

                // Overlapping Card
                Positioned(
                  bottom: -55.h,
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
                    onTap: () => Get.to(() => AboutSkilzvillaScreen()),
                  ),
                  ListTileOptions(
                    imageName: Appimages.faq,
                    title: 'FAQ',
                    onTap: () => Get.to(() => FaqScreen()),
                  ),
                  ListTileOptions(
                    imageName: Appimages.policies,
                    title: 'Policies',
                    onTap: () => Get.to(() => PoliciesScreen()),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10.h),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularButton(
                buttonColor: kPrimary,
                buttonText: "Log Out",
                onPressed: _logout,
                width: width,
                height: 40.h,
              ),
            ),
            SizedBox(height: 10.h),
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
