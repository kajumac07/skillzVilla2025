import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/global/widgets/rounded_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddServiceScreen extends StatefulWidget {
  const AddServiceScreen({super.key});

  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  String? category = 'Healthcare';
  String? subCategory = 'Hospitals';
  final TextEditingController pricingController = TextEditingController(
    text: '600 per ambulance',
  );
  final List<String> included = ['Ventilator', 'Critical care medicines'];
  final List<String> excluded = ['Ventilator', 'Critical care medicines'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: CustomText(
          label: "Add New Service",
          size: 18.sp,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  label: "Enter service details",
                  size: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: kGrey300,
                ),
                SizedBox(height: 16.h),

                // Category Dropdown
                _buildLabel("Category"),
                _buildDropdown(category!, [
                  'Healthcare',
                  'Education',
                  'Transport',
                ]),
                SizedBox(height: 12.h),

                // Sub-Category Dropdown
                _buildLabel("Sub-Category"),
                _buildDropdown(subCategory!, ['Hospitals', 'Clinics', 'Labs']),
                SizedBox(height: 20.h),

                // Services & Duration
                _buildLabel("Services & Duration"),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Expanded(child: _buildBoxField("Ambulance")),
                    SizedBox(width: 8.w),
                    Expanded(child: _buildBoxField("1 hour")),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Expanded(child: _buildTextField("Pick up")),
                    SizedBox(width: 8.w),
                    Expanded(child: _buildTextField("1 hour")),
                  ],
                ),
                SizedBox(height: 20.h),

                // Pricing
                _buildLabel("Pricing"),
                _buildTextField("600 per ambulance"),
                SizedBox(height: 20.h),

                // Services Included
                _buildLabel("Services included"),
                _buildChips(included),
                _buildTextField("Type here..."),
                SizedBox(height: 20.h),

                // Services Excluded
                _buildLabel("Services excluded"),
                _buildChips(excluded),
                _buildTextField("Type here..."),
                SizedBox(height: 15.h),

                _buildLabel("Full Description"),
                SizedBox(height: 15.h),
                RoundedTextField(
                  label: "Enter.....",
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  maxLines: 3,
                  fillColor: Color(0xffF3F4F9),
                ),
                SizedBox(height: 15.h),

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
                        label: "Upload Images",
                        size: 14.sp,
                        color: kGrey300,
                        fontWeight: FontWeight.w300,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40.h),

                //submit button
                CircularButton(
                  buttonColor: kPrimary,
                  buttonText: "Save details",
                  onPressed: () {},
                  width: width,
                ),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        children: [
          CustomText(
            label: text,
            size: 14.sp,
            color: Color(0xff23334A),
            fontWeight: FontWeight.w500,
          ),
          CustomText(
            label: "*",
            size: 14.sp,
            color: kPrimary,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String value, List<String> items) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        border: Border.all(color: kGrey100),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: kGrey400),
          items: items
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
                    style: appStyle(14.sp, kGrey200, FontWeight.w200),
                  ),
                ),
              )
              .toList(),
          onChanged: (val) => setState(() {
            if (items.contains(val)) value = val!;
          }),
        ),
      ),
    );
  }

  Widget _buildBoxField(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Color(0xffF3F4F9),
      ),
      child: Text(text, style: appStyle(14.sp, kGrey300, FontWeight.w200)),
    );
  }

  Widget _buildTextField(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: appStyle(14.sp, kGrey100, FontWeight.w300),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Color(0xffE3E8EC)),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      ),
    );
  }

  Widget _buildChips(List<String> items) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: items
          .map(
            (e) => Chip(
              side: BorderSide(color: Color(0xffE3E8EC)),
              label: Text(e),
              onDeleted: () => setState(() => items.remove(e)),
              deleteIcon: const Icon(Icons.close, size: 16),
              backgroundColor: kWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
          )
          .toList(),
    );
  }
}
