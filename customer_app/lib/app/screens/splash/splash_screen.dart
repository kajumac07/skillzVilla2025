import 'dart:developer';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/screens/welcome/welcome_screen.dart';
import 'package:customer_app/app/screens/providerSide/kyc/kyc_screen.dart';
import 'package:customer_app/app/screens/providerSide/kyc/widgets/kyc_docs_screen.dart';
import 'package:customer_app/root_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _navigateAfterSplash();
  }

  Future<void> _navigateAfterSplash() async {
    // Wait for 3 seconds (splash delay)
    await Future.delayed(const Duration(seconds: 3));

    try {
      final User? user = _auth.currentUser;

      if (user == null) {
        // User not logged in - go to WelcomeScreen
        log("SplashScreen → User not logged in");
        Get.offAll(() => const WelcomeScreen());
        return;
      }

      // Fetch user data from Firestore
      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(user.uid)
          .get();

      if (!userDoc.exists) {
        // User document doesn't exist - go to WelcomeScreen
        log("SplashScreen → User document not found");
        Get.offAll(() => const WelcomeScreen());
        return;
      }

      // Extract user data
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      String userType = userData['userType'] ?? 'customer';
      String kycType = userData['kycType'] ?? 'customer';
      bool isDocSubmitted = userData['isDocSubmitted'] ?? false;

      log(
        "SplashScreen → userType: $userType | kycType: $kycType | isDocSubmitted: $isDocSubmitted",
      );

      if (userType == 'customer') {
        Get.offAll(() => const RootScreen());
      } else if (userType == 'provider') {
        // Provider logic
        if (kycType == 'company' || kycType == 'freelance') {
          if (isDocSubmitted == true) {
            Get.offAll(() => const RootScreen());
          } else {
            Get.offAll(() => KycDocsScreen());
          }
        } else {
          Get.offAll(() => const KycScreen());
        }
      } else {
        // Fallback for any other user type
        Get.offAll(() => const RootScreen());
      }
    } catch (e) {
      log("SplashScreen → Error: $e");
      // If any error occurs, go to WelcomeScreen as fallback
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
