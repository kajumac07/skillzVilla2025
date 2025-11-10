import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_divider.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/screens/providerSide/serviceAndPlanning/widgets/add_service_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PServiceNdPlanningScreen extends StatelessWidget {
  const PServiceNdPlanningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          label: "My Service & Pricing",
          size: 20.sp,
          color: kGrey400,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Services List
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.h),
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemCount: 6,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 8.h),
                        itemBuilder: (context, index) =>
                            MyServiceCards(width: width),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Add Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 7.h),
              child: CircularButton(
                buttonColor: kPrimary,
                buttonText: "Add Service",
                onPressed: () => Get.to(() => const AddServiceScreen()),
                width: width,
              ),
            ),

            // SizedBox(height: height * 0.01),
          ],
        ),
      ),
    );
  }
}

class MyServiceCards extends StatelessWidget {
  const MyServiceCards({super.key, required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.all(10.h),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //top section
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Image.asset(
              Appimages.sCheckIcon,
              height: 16.h,
              width: 16.w,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  label: "Ambulance Service",
                  size: 14.sp,
                  color: kGrey300,
                  fontWeight: FontWeight.bold,
                ),
                CustomText(label: "Healthcare", size: 12.sp, color: kGrey200),
              ],
            ),
            trailing: Image.asset(
              Appimages.deleteIcon,
              height: 32.h,
              width: 32.w,
            ),
          ),
          SizedBox(height: 5.h),
          CustomDivider(),
          SizedBox(height: 5.h),
          //price and duration section
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    label: "Pricing",
                    size: 12.sp,
                    color: kGrey200,
                    fontWeight: FontWeight.w300,
                  ),
                  CustomText(
                    label: "600/ambulance",
                    size: 14.sp,
                    color: kGrey300,
                    fontWeight: FontWeight.w300,
                  ),
                ],
              ),
              Spacer(),
              //vertical divider
              Container(
                height: 40.h,
                width: 1.w,
                decoration: BoxDecoration(color: Color(0xffCED6DE)),
              ),
              // Spacer(),
              SizedBox(width: 30.w),

              //right side content
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    label: "Duration",
                    size: 12.sp,
                    color: kGrey200,
                    fontWeight: FontWeight.w300,
                  ),
                  CustomText(
                    label: "1 hour",
                    size: 14.sp,
                    color: kGrey300,
                    fontWeight: FontWeight.w300,
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
          SizedBox(height: 5.h),
          CustomDivider(),
          SizedBox(height: 5.h),
          CustomText(
            label: "Additional Services",
            size: 12.sp,
            color: kGrey200,
          ),
          SizedBox(height: 5.h),

          //additional services
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              buildAdditionalServices("Ventilator"),
              buildAdditionalServices("Critical care medicines"),
              buildAdditionalServices("First Aid"),
              buildAdditionalServices("Wheelchair"),
            ],
          ),
          SizedBox(height: 5.h),
          CustomDivider(),
          SizedBox(height: 5.h),
          Row(
            children: [
              Expanded(
                child: CircularButton(
                  buttonColor: kPrimary,
                  buttonText: "View more",
                  onPressed: () {},
                  height: 40.h,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: Text("Edit details"),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: kPrimary),
                    backgroundColor: kWhite,
                    foregroundColor: kGrey300,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildAdditionalServices(String title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        border: Border.all(color: kGrey400),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(title, style: appStyle(14.sp, kGrey300, FontWeight.w300)),
    );
  }
}
