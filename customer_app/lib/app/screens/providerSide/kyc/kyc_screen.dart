import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/services/shared_pref.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/screens/providerSide/kyc/widgets/kyc_docs_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class KycScreen extends StatefulWidget {
  const KycScreen({super.key});

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {
  final _sharedPref = AppSharedPrefData();
  String? _selectedType;

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
                buttonColor: _selectedType != null
                    ? kPrimary
                    : Colors.grey.shade300,
                buttonText: "Next",
                onPressed: _selectedType == null
                    ? null
                    : () {
                        Get.to(() => const KycDocsScreen());
                      },
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
      onTapDown: (_) {
        // add immediate visual feedback
        setState(() => _selectedType = title);
      },
      onTapUp: (_) async {
        await _sharedPref.saveKycType(title);
        // optional: trigger a small delay to let animation finish
        await Future.delayed(const Duration(milliseconds: 100));
      },
      child: AnimatedScale(
        duration: const Duration(milliseconds: 150),
        scale: isSelected ? 1.05 : 1.0, // scale-up on selection
        curve: Curves.easeOutBack,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: CircularButton(
            buttonColor: color,
            buttonText: title,
            onPressed: () async {
              setState(() => _selectedType = title);
              await _sharedPref.saveKycType(title);
            },
            height: 40.h,
            textSize: 16.sp,
          ),
        ),
      ),
    );
  }
}
























  // Widget buildFreelanceAndCompany(String title) {
  //   final isSelected = _selectedType == title;

  //   return GestureDetector(
  //     onTap: () async {
  //       setState(() {
  //         _selectedType = title;
  //       });
  //       await _sharedPref.saveKycType(title);
  //     },
  //     child: AnimatedContainer(
  //       duration: const Duration(milliseconds: 200),
  //       height: 150.h,
  //       width: 150.w,
  //       decoration: BoxDecoration(
  //         color: isSelected ? kPrimary.withOpacity(0.15) : kFFF9D1,
  //         borderRadius: BorderRadius.circular(15.r),
  //         // border: Border.all(
  //         //   color: isSelected ? kPrimary : Colors.transparent,
  //         //   width: 2,
  //         // ),
  //       ),
  //       child: Stack(
  //         children: [
  //           Positioned(
  //             bottom: 0,
  //             child: Container(
  //               height: 66.h,
  //               width: 150.w,
  //               decoration: BoxDecoration(
  //                 color: isSelected ? kPrimary : kDAFAFF,
  //                 borderRadius: BorderRadius.only(
  //                   topLeft: title == "Freelance"
  //                       ? Radius.circular(50.r)
  //                       : Radius.zero,
  //                   topRight: title == "Company"
  //                       ? Radius.circular(40.r)
  //                       : Radius.zero,
  //                   bottomLeft: Radius.circular(15.r),
  //                   bottomRight: Radius.circular(15.r),
  //                 ),
  //               ),
  //             ),
  //           ),
  //           Positioned(
  //             bottom: 10,
  //             left: 0,
  //             right: 0,
  //             child: Container(
  //               padding: EdgeInsets.all(4.h),
  //               margin: EdgeInsets.only(left: 20.w, right: 20.w),
  //               decoration: BoxDecoration(
  //                 color: isSelected ? kPrimary : kSecondary,
  //                 borderRadius: BorderRadius.circular(20.r),
  //               ),
  //               child: Center(
  //                 child: Text(
  //                   title,
  //                   style: TextStyle(
  //                     color: isSelected ? Colors.white : Colors.black,
  //                     fontWeight: FontWeight.w600,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }