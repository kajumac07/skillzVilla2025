import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/controller/profile_controller.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_divider.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/global/widgets/icon_tap_image.dart';
import 'package:customer_app/app/global/widgets/list_tile_options.dart';
import 'package:customer_app/app/screens/about/about_skilzvilla_screen.dart';
import 'package:customer_app/app/screens/faqs/faq_screen.dart';
import 'package:customer_app/app/screens/notifications/notification_screens.dart';
import 'package:customer_app/app/screens/policies/policies_screen.dart';
import 'package:customer_app/app/screens/providerSide/requestLocation/request_location_screen.dart';
import 'package:customer_app/app/screens/userSide/myBookings/my_bookings_screen.dart';
import 'package:customer_app/app/screens/userSide/profileScreen/editProfile/edit_profile_screen.dart';
import 'package:customer_app/app/screens/userSide/profileScreen/widgets/my_reviews_nd_rating.dart';
import 'package:customer_app/app/screens/userSide/profileScreen/widgets/profile_address_screen.dart';
import 'package:customer_app/app/screens/userSide/profileScreen/widgets/profile_settings_screen.dart';
import 'package:customer_app/app/screens/userSide/wallets/wallet_screen.dart';
import 'package:customer_app/app/screens/welcome/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.find<ProfileController>();

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(() => const WelcomeScreen());
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
          if (profileController.canEditProfile)
            TapImageIcon(
              imageName: Appimages.editIcon,
              onTap: () {
                Get.to(() => EditProfileScreen());
              },
            ),
          SizedBox(width: 10.w),
        ],
      ),
      body: GetBuilder<ProfileController>(
        builder: (controller) {
          if (controller.isLoading) {
            return Center(
              child: CircularProgressIndicator(backgroundColor: kPrimary),
            );
          }

          if (!controller.hasUserData) {
            return _buildErrorState();
          }
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // ✅ Fixed Top Profile Section (using Stack)
                SizedBox(
                  height: 270.h,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Background profile image
                      Positioned(
                        top: 20.h,
                        left: 20.w,
                        right: 20.w,
                        child: Container(
                          height: 224.h,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(Appimages.profileBg2),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomText(
                                label: profileController.userModel!.name,
                                fontWeight: FontWeight.bold,
                                size: 15.sp,
                              ),
                              CustomText(
                                label: profileController.userModel!.phNumber,
                                size: 12.sp,
                              ),
                              SizedBox(height: 25.h),
                            ],
                          ),
                        ),
                      ),

                      // Profile image
                      Positioned(
                        top: 60.h,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 105.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: kRed,
                            image: DecorationImage(
                              image: NetworkImage(
                                profileController.userModel!.imageUrl,
                              ),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),

                      // Camera icon (top-right corner)
                      Positioned(
                        top: 27.h,
                        right: 40.w,
                        child: Image.asset(
                          Appimages.cameraIcon,
                          height: 24.h,
                          width: 44.w,
                        ),
                      ),

                      // Overlapping white card (Wallet, Bookings, Help)
                      Positioned(
                        bottom: -25.h,
                        left: 10.w,
                        right: 10.w,
                        child: Container(
                          height: 70.h,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(12.r),
                            boxShadow: [
                              BoxShadow(
                                color: kPrimaryLight,
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // SizedBox(width: 2.w),
                              Expanded(
                                child: _buildProfileOption(
                                  image: Appimages.walletIcon,
                                  title: 'Wallet',
                                  onTap: () => Get.to(() => WalletScreen()),
                                ),
                              ),
                              SizedBox(width: 40.w),
                              Expanded(
                                child: _buildProfileOption(
                                  image: Appimages.privacy,
                                  title: 'My Bookings',
                                  onTap: () => Get.to(() => MyBookingsScreen()),
                                ),
                              ),
                              SizedBox(width: 40.w),
                              Expanded(
                                child: _buildProfileOption(
                                  image: Appimages.helpCenter,
                                  title: 'Help & Support',
                                  onTap: () {},
                                ),
                              ),
                              // SizedBox(width: 10.w),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                // ✅ Your Information Section
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
                        onTap: () =>
                            Get.to(() => ManageProfileAddressscreens()),
                      ),
                      ListTileOptions(
                        imageName: Appimages.pSetting,
                        title: 'Settings',
                        onTap: () => Get.to(() => ProfileSettingsScreen()),
                      ),
                      if (profileController.userType == "Customer" &&
                          profileController.kycType == "Customer")
                        ...[]
                      else ...[
                        ListTileOptions(
                          imageName: Appimages.pDoc,
                          title: 'Relocation Request',
                          onTap: () => Get.to(() => RequestLocationScreen()),
                        ),
                      ],
                    ],
                  ),
                ),

                // ✅ More Section
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
                SizedBox(height: 20.h),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.grey),
          SizedBox(height: 16.h),
          Text(
            'Unable to load profile',
            style: appStyle(16.sp, kDark, FontWeight.w500),
          ),
          SizedBox(height: 8.h),
          Text(
            'Please check your connection and try again',
            style: appStyle(12.sp, Colors.grey, FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          CircularButton(
            buttonColor: kPrimary,
            buttonText: "Try Again",
            onPressed: profileController.fetchUserProfile,
            width: 120.w,
          ),
        ],
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
      child: Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Color(0xffF9F7F7),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, height: 20.h, width: 20.w),
            // SizedBox(height: 4.h),
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: appStyle(11.sp, kGrey400, FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
