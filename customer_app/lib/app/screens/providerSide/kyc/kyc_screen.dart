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

  String? _selectedType; // 'Freelance' or 'Company'

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
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Container(
                padding: EdgeInsets.all(8.h),
                margin: EdgeInsets.all(8.h),
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(Appimages.logo, width: 60.w, height: 44.h),
                        const Spacer(),
                        CustomText(
                          label: "Enter As",
                          size: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        const Spacer(),
                      ],
                    ),
                    SizedBox(height: 10.h),

                    // Freelance / Company Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildFreelanceAndCompany("Freelance"),
                        buildFreelanceAndCompany("Company"),
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              CircularButton(
                buttonColor: _selectedType != null
                    ? kPrimary
                    : Colors.grey.shade300,
                buttonText: "Next",
                onPressed: _selectedType == null
                    ? null
                    : () {
                        Get.to(() => const KycDocsScreen());
                      },
                width: width,
              ),

              // SizedBox(height: height * 0.03),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // ✅ Custom widget for Freelance/Company box
  // ---------------------------------------------------------------------------
  Widget buildFreelanceAndCompany(String title) {
    final isSelected = _selectedType == title;

    return GestureDetector(
      onTap: () async {
        setState(() {
          _selectedType = title;
        });
        await _sharedPref.saveKycType(title); // Save 'Freelance' or 'Company'
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 150.h,
        width: 150.w,
        decoration: BoxDecoration(
          color: isSelected ? kPrimary.withOpacity(0.15) : kFFF9D1,
          borderRadius: BorderRadius.circular(15.r),
          // border: Border.all(
          //   color: isSelected ? kPrimary : Colors.transparent,
          //   width: 2,
          // ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                height: 66.h,
                width: 150.w,
                decoration: BoxDecoration(
                  color: isSelected ? kPrimary : kDAFAFF,
                  borderRadius: BorderRadius.only(
                    topLeft: title == "Freelance"
                        ? Radius.circular(50.r)
                        : Radius.zero,
                    topRight: title == "Company"
                        ? Radius.circular(40.r)
                        : Radius.zero,
                    bottomLeft: Radius.circular(15.r),
                    bottomRight: Radius.circular(15.r),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(4.h),
                margin: EdgeInsets.only(left: 20.w, right: 20.w),
                decoration: BoxDecoration(
                  color: isSelected ? kPrimary : kSecondary,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
