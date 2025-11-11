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

  // For Services & Duration dynamic list
  List<Map<String, String>> services = [
    {"service": "Ambulance", "duration": "1 hour"},
  ];

  final TextEditingController serviceController = TextEditingController();
  final TextEditingController durationController = TextEditingController();

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
          physics: const BouncingScrollPhysics(),
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

                _buildServicesDurationSection(),
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
                  fillColor: const Color(0xffF3F4F9),
                ),
                SizedBox(height: 15.h),

                Container(
                  height: 95.h,
                  width: width,
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: const Color(0xffE3E8EC)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 25.r,
                        backgroundColor: const Color(0xffE3E8EC),
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

                // Submit button
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

  // 🔹 Helper: Label with red asterisk
  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        children: [
          CustomText(
            label: text,
            size: 14.sp,
            color: const Color(0xff23334A),
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

  // 🔹 Helper: Dropdown field
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

  // 🔹 Helper: Reusable TextField
  Widget _buildTextField(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: appStyle(14.sp, kGrey100, FontWeight.w300),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xffE3E8EC)),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      ),
    );
  }

  // 🔹 Helper: Chips for included/excluded
  Widget _buildChips(List<String> items) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: items
          .map(
            (e) => Chip(
              side: const BorderSide(color: Color(0xffE3E8EC)),
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

  Widget _buildServicesDurationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("Services & Duration"),
        SizedBox(height: 8.h),

        // Display existing service-duration pairs
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: services.map((entry) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Service Box
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                      horizontal: 14.w,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffF3F4F9),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      entry["service"]!,
                      style: appStyle(14.sp, kGrey400, FontWeight.w500),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                // Spacer(),

                // Duration Box with close icon stacked
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      padding: EdgeInsets.symmetric(
                        vertical: 10.h,
                        horizontal: 14.w,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffF3F4F9),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        entry["duration"]!,
                        style: appStyle(14.sp, kGrey400, FontWeight.w400),
                      ),
                    ),
                    Positioned(
                      top: -6,
                      right: -6,
                      child: GestureDetector(
                        onTap: () => setState(() => services.remove(entry)),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: kGrey100, width: 1),
                          ),
                          padding: EdgeInsets.all(3.w),
                          child: Icon(
                            Icons.close,
                            size: 14.sp,
                            color: kGrey300,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }).toList(),
        ),

        SizedBox(height: 16.h),

        // Input fields for adding new pair
        Row(
          children: [
            Expanded(
              child: _buildTextFieldWithController(
                controller: serviceController,
                hint: "Pick up",
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: _buildTextFieldWithController(
                controller: durationController,
                hint: "1 hour",
              ),
            ),
          ],
        ),

        SizedBox(height: 12.h),

        // Add button
        Center(
          child: GestureDetector(
            onTap: () {
              if (serviceController.text.isNotEmpty &&
                  durationController.text.isNotEmpty) {
                setState(() {
                  services.add({
                    "service": serviceController.text,
                    "duration": durationController.text,
                  });
                  serviceController.clear();
                  durationController.clear();
                });
              }
            },
            child: CircleAvatar(
              radius: 24.r,
              backgroundColor: kPrimary,
              child: Icon(Icons.add, color: Colors.white, size: 26.sp),
            ),
          ),
        ),
      ],
    );
  }

  // 🔹 TextField with controller
  Widget _buildTextFieldWithController({
    required TextEditingController controller,
    required String hint,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: appStyle(14.sp, kGrey100, FontWeight.w300),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xffE3E8EC)),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      ),
    );
  }
}
