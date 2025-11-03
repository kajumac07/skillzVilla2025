import 'dart:developer';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/services/shared_pref.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/screens/welcome/welcome_screen.dart';
import 'package:customer_app/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _sharedPref = AppSharedPrefData();

  @override
  void initState() {
    super.initState();
    _navigateAfterSplash();
  }

  Future<void> _navigateAfterSplash() async {
    // Wait for 3 seconds (splash delay)
    await Future.delayed(const Duration(seconds: 3));

    // Fetch userType and kycType from SharedPreferences
    final userType = await _sharedPref.getUserType();
    final kycType = await _sharedPref.getKycType();

    log("SplashScreen → userType: $userType | kycType: $kycType");

    // Check conditions
    if (userType != null && kycType != null) {
      // ✅ Both available — go to RootScreen
      Get.offAll(() => const RootScreen());
    } else {
      // ❌ Missing data — go to WelcomeScreen
      Get.offAll(() => const WelcomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Appimages.slashBg),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Appimages.logo, width: 203.w, height: 174.h),
            SizedBox(height: 15.h),
            CustomText(
              label: "All Services at Your Door Step.",
              size: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
