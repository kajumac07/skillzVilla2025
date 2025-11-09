import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/global/widgets/rounded_text_field.dart';
import 'package:customer_app/app/screens/providerSide/kyc/widgets/subscription_plan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class KycDocsScreen extends StatelessWidget {
  const KycDocsScreen({super.key});

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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            UploadIDCard(
              primaryBg: Color(0xffF6FEFF),
              borderColor: kSecondary,
              secondaryBg: kSecondaryLight,
              label: "ID No:",
              iconColor: kSecondary,
              title: "Upload Docs",
            ),

            UploadIDCard(
              primaryBg: Color(0xffFFF8F8),
              borderColor: kPrimaryLight,
              secondaryBg: kPrimaryLight,
              label: "License No. :",
              iconColor: kPrimary,
              title: "Upload Docs",
            ),
            UploadIDCard(
              primaryBg: Color(0xffF7F2DE),
              borderColor: kFFF9D1,
              secondaryBg: kFFF9D1,
              label: "License No. :",
              iconColor: Color(0xffF1E7A3),
              isUploadDocs: true,
              title: "Upload Docs",
            ),
            UploadIDCard(
              primaryBg: Color(0xffF5F5F5),
              borderColor: Color(0xffF5F5F5),
              secondaryBg: Color(0xffE3E8EC),
              label: "License No. :",
              iconColor: kPrimary,
              isUploadDocs: true,
              title: "Criminal Record Docs",
            ),
            // SizedBox(height: 10.h),
            Container(
              padding: EdgeInsets.all(12.r),
              margin: EdgeInsets.all(12.r),
              child: CircularButton(
                buttonColor: kPrimary,
                buttonText: "Submit",
                onPressed: () {
                  Get.to(() => SubscriptionPlanPricingScreen());
                },
                width: width,
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),

      // bottomSheet: // Add Button
      // Container(
      //   padding: EdgeInsets.all(12.r),
      //   margin: EdgeInsets.all(12.r),
      //   child: CircularButton(
      //     buttonColor: kPrimary,
      //     buttonText: "Submit",
      //     onPressed: () {
      //       Get.to(() => SubscriptionPlanPricingScreen());
      //     },
      //     width: width,
      //   ),
      // ),
    );
  }
}

class UploadIDCard extends StatelessWidget {
  const UploadIDCard({
    super.key,
    required this.primaryBg,
    required this.borderColor,
    required this.secondaryBg,
    required this.label,
    required this.iconColor,
    this.isUploadDocs = false,
    required this.title,
  });
  final Color primaryBg;
  final Color borderColor;
  final Color secondaryBg;
  final String label;
  final Color iconColor;
  final bool isUploadDocs;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.h),
      margin: EdgeInsets.all(12.h),
      decoration: BoxDecoration(
        color: primaryBg,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isUploadDocs
              ? CustomText(label: title, size: 14.sp, color: kGrey300)
              : RoundedTextField(
                  label: label,
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  isBorderEnable: true,
                ),
          SizedBox(height: 10.h),

          Container(
            height: 95.h,
            width: width,
            decoration: BoxDecoration(
              color: secondaryBg,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 25.r,
                  backgroundColor: iconColor,
                  child: Icon(Icons.cloud_upload_outlined, color: kWhite),
                ),
                SizedBox(height: 2.h),
                CustomText(
                  label: "Upload Images",
                  size: 14.sp,
                  color: kGrey300,
                  fontWeight: FontWeight.w300,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
