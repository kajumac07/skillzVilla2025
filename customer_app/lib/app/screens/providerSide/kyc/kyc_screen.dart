import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/screens/providerSide/kyc/widgets/kyc_docs_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class KycScreen extends StatelessWidget {
  const KycScreen({super.key});

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
      body: Container(
        padding: EdgeInsets.all(8.h),
        // margin: EdgeInsets.all(8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                      Spacer(),
                      CustomText(
                        label: "Enter As",
                        size: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  //container
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildFreelanceAndCompany("Freelance", true),
                      buildFreelanceAndCompany("Company", false),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: CircularButton(
          buttonColor: kPrimary,
          buttonText: "Next",
          onPressed: () => Get.to(() => KycDocsScreen()),
        ),
      ),
    );
  }

  Widget buildFreelanceAndCompany(String title, bool isFreelance) {
    return Stack(
      children: [
        Container(
          height: 150.h,
          width: 150.w,
          decoration: BoxDecoration(
            color: kFFF9D1,
            borderRadius: BorderRadius.circular(15.r),
          ),
        ),

        Positioned(
          bottom: 0,
          child: Container(
            height: 66.h,
            width: 150.w,
            decoration: BoxDecoration(
              color: kDAFAFF,
              borderRadius: BorderRadius.only(
                topLeft: isFreelance ? Radius.circular(50.r) : Radius.zero,
                topRight: isFreelance ? Radius.zero : Radius.circular(50.r),
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
              color: kSecondary,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Center(child: Text(title)),
          ),
        ),
      ],
    );
  }
}
