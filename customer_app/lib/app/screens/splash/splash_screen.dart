import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/screens/auth/login_screen.dart';
import 'package:customer_app/app/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAll(() => const WelcomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(Appimages.logo, width: 203.w, height: 174.h),
          ),
          SizedBox(height: 15.h),
          CustomText(
            label: "All Services at Your Door Step.",
            size: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
