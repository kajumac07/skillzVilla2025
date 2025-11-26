import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/controller/auth_controller.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/screens/providerSide/kyc/widgets/kyc_docs_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class KycScreen extends StatefulWidget {
  const KycScreen({super.key});

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {
  final AuthController authCont = Get.find<AuthController>();
  String? _selectedType;
  bool _isUpdating = false;

  // Function to update kycType in Firebase
  Future<void> _updateKycType() async {
    if (_selectedType == null) return;

    try {
      setState(() {
        _isUpdating = true;
      });

      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Get.snackbar("Error", "User not logged in");
        return;
      }

      // Update kycType in Firestore
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update(
        {
          'kycType': _selectedType!.toLowerCase(), // 'company' or 'freelance'
          'updatedAt': FieldValue.serverTimestamp(),
        },
      );

      // Navigate to KYC Docs screen
      Get.to(() => KycDocsScreen());
    } catch (e) {
      Get.snackbar("Error", "Failed to update KYC type: ${e.toString()}");
    } finally {
      setState(() {
        _isUpdating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          label: "KYC",
          size: 20.sp,
          color: kGrey400,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),

            // ✅ Card with background image, logo, illustration, and buttons
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                image: DecorationImage(
                  image: AssetImage(Appimages.kycBg),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo on top-left corner
                  Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      Appimages.logo,
                      width: 70.w,
                      height: 50.h,
                    ),
                  ),
                  SizedBox(height: 8.h),

                  // Center Image
                  Image.asset(Appimages.kycImage, height: 180.h),
                  SizedBox(height: 12.h),

                  // Enter As Text
                  CustomText(
                    label: "Enter As",
                    size: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  SizedBox(height: 12.h),

                  // Freelance / Company buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: buildFreelanceAndCompany("Company", kPrimary),
                      ),
                      SizedBox(width: 15.w),
                      Expanded(
                        child: buildFreelanceAndCompany(
                          "Freelance",
                          kSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Spacer(),

            // ✅ Bottom Next Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: CircularButton(
                buttonColor: _selectedType != null && !_isUpdating
                    ? kPrimary
                    : Colors.grey.shade300,
                buttonText: _isUpdating ? "Updating..." : "Next",
                onPressed: _selectedType != null && !_isUpdating
                    ? _updateKycType
                    : null,
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget buildFreelanceAndCompany(String title, Color color) {
    final bool isSelected = _selectedType == title;

    return GestureDetector(
      onTap: () {
        setState(() => _selectedType = title);
      },
      child: AnimatedScale(
        duration: const Duration(milliseconds: 150),
        scale: isSelected ? 1.05 : 1.0,
        curve: Curves.easeOutBack,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: CircularButton(
            buttonColor: color,
            buttonText: title,
            onPressed: () {
              setState(() => _selectedType = title);
            },
            height: 40.h,
            textSize: 16.sp,
          ),
        ),
      ),
    );
  }
}
