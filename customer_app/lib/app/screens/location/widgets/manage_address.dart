import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ManageAddressScreen extends StatelessWidget {
  const ManageAddressScreen({super.key, required this.userType});
  final String userType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kWhite,
      body: Column(
        children: [
          // Map section
          builTopSection(context),

          // Address details section
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: Container(
                // color: Colors.white,
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enter Address Details',
                      style: appStyle(18.sp, kGrey400, FontWeight.w300),
                    ),
                    SizedBox(height: 7.h),
                    Row(
                      children: [
                        Image.asset(Appimages.mapIcon, color: kGreenAccent),
                        SizedBox(width: 5.w),
                        CustomText(
                          label: "Luxmi Lok Sector24, Panchkula, Haryana",
                          color: kGrey300,
                          size: 12.sp,
                        ),
                        Spacer(),
                        CustomText(
                          label: "Change",
                          color: kPrimary,
                          size: 12.sp,
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                    Container(
                      padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 8.h),
                      // margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Form fields
                          _buildTextField('House/Flat'),
                          SizedBox(height: 15),
                          _buildTextField('Landmark'),
                          SizedBox(height: 15),
                          _buildTextField('Name'),
                          SizedBox(height: 15),
                          _buildTextField('Mobile'),
                          SizedBox(height: 25),
                          // Save as section
                          CustomText(
                            label: "Save as",
                            size: 16.sp,
                            color: kGrey400,
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 32.h,
                                  width: 95.w,
                                  decoration: BoxDecoration(
                                    color: kGrey300,
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Center(
                                    child: CustomText(
                                      label: "Home",
                                      color: surface200,
                                      size: 12.sp,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 32.h,
                                  width: 95.w,
                                  decoration: BoxDecoration(
                                    color: kWhite,
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(color: kGrey100),
                                  ),
                                  child: Center(
                                    child: CustomText(
                                      label: "Work",
                                      color: kGrey300,
                                      size: 12.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                        ],
                      ),
                    ),

                    SizedBox(height: 10),
                    CircularButton(
                      buttonColor: kPrimary,
                      buttonText: "Save Address",
                      onPressed: () => Get.to(() => RootScreen()),
                      width: width,
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Expanded builTopSection(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Stack(
        children: [
          // Map background
          Image(
            image: AssetImage(Appimages.locationBgImage),
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          // Back button
          Positioned(
            top: 50,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(Icons.arrow_back_ios, size: 20.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String hintText) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: surface200,
        filled: true,
        hintStyle: appStyle(14, kGrey300, FontWeight.w300),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
