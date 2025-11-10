import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/global/widgets/rounded_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportJobScreen extends StatefulWidget {
  const ReportJobScreen({super.key});

  @override
  State<ReportJobScreen> createState() => _ReportJobScreenState();
}

class _ReportJobScreenState extends State<ReportJobScreen> {
  String? selectedIssueType;
  final TextEditingController issueController = TextEditingController();
  final List<String> services = ['Male', 'Female', 'Other'];
  String? selectedService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: CustomText(
          label: "Report an Issue",
          size: 18.sp,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(12.w),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black12,
                  //     blurRadius: 6,
                  //     offset: const Offset(0, 2),
                  //   ),
                  // ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RoundedTextField(
                        label: "Booking ID :",
                        obscureText: false,
                        keyboardType: TextInputType.name,
                        fillColor: Color(0xffF3F4F9),
                      ),
                      SizedBox(height: 10.h),
                      _buildDropdown(
                        "Service :",
                        services,
                        selectedService,
                        (val) => setState(() => selectedService = val),
                      ),
                      SizedBox(height: 10.h),
                      RoundedTextField(
                        label: "Date :",
                        obscureText: false,
                        keyboardType: TextInputType.name,
                        fillColor: Color(0xffF3F4F9),
                      ),

                      SizedBox(height: 20.h),
                      CustomText(
                        label: "Select Issue Type",
                        size: 14.sp,
                        color: kGrey300,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 8.h),

                      // --- Radio Buttons ---
                      _buildRadio("Service Quality"),
                      _buildRadio("Provider was late"),
                      _buildRadio("Wrong Charges"),
                      _buildRadio("Damage"),
                      _buildRadio("Other"),

                      SizedBox(height: 20.h),
                      CustomText(
                        label: "Describe Issue",
                        size: 14.sp,
                        color: kGrey300,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 8.h),

                      // --- Description Box ---
                      RoundedTextField(
                        label: "Enter...",
                        obscureText: false,
                        keyboardType: TextInputType.name,
                        fillColor: Color(0xffF3F4F9),
                        maxLines: 3,
                      ),

                      SizedBox(height: 20.h),

                      // --- Upload Proof Box ---
                      Container(
                        height: 95.h,
                        width: width,
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: Color(0xffE3E8EC)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 25.r,
                              backgroundColor: Color(0xffE3E8EC),
                              child: Icon(
                                Icons.cloud_upload_outlined,
                                color: kPrimary,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            CustomText(
                              label: "Upload Proof",
                              size: 14.sp,
                              color: kGrey300,
                              fontWeight: FontWeight.w300,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 30.h),
              // --- Buttons ---
              CircularButton(
                buttonColor: kPrimary,
                buttonText: "Submit",
                onPressed: () {},
                height: 48.h,
                width: width,
              ),
              SizedBox(height: 10.h),
              CircularButton(
                buttonColor: Color(0xffE3E8EC),
                buttonText: "Cancel",
                onPressed: () {},
                height: 48.h,
                width: width,
                textColor: kGrey400,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 Custom Dropdown Field
  Widget _buildDropdown(
    String label,
    List<String> items,
    String? selectedValue,
    ValueChanged<String?> onChanged,
  ) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: const Color(0xffF3F4F9),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: appStyle(13.sp, kGrey300, FontWeight.w400),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        ),
        value: selectedValue,
        icon: Icon(Icons.arrow_drop_down_rounded, color: kGrey400, size: 30.sp),
        items: items
            .map(
              (val) => DropdownMenuItem(
                value: val,
                child: Text(
                  val,
                  style: appStyle(14.sp, Colors.black87, FontWeight.w400),
                ),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildRadio(String label) {
    return Container(
      margin: EdgeInsets.only(bottom: 6.h),
      decoration: BoxDecoration(
        color: Color(0xffF9F7F7),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: RadioListTile<String>(
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
        title: CustomText(
          label: label,
          size: 13.sp,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        value: label,
        groupValue: selectedIssueType,
        activeColor: Colors.redAccent,
        onChanged: (value) {
          setState(() => selectedIssueType = value);
        },
      ),
    );
  }
}
