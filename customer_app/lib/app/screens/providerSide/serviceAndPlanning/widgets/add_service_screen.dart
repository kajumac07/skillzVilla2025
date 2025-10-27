import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/values/app_images.dart';
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
  final List<String> stepsImages = [
    Appimages.step1,
    Appimages.step2,
    Appimages.step3,
  ];

  int _currentStep = 0;
  final PageController _pageController = PageController();

  // Form controllers
  final TextEditingController _serviceNameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _fullDescriptionController =
      TextEditingController();
  final TextEditingController _serviceDurationController =
      TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _availabilityController = TextEditingController();
  final TextEditingController _customAvailabilityController =
      TextEditingController();

  String _selectedPriceModel = 'Per Hour';
  final List<String> _uploadedImages = [];

  @override
  void dispose() {
    _pageController.dispose();
    _serviceNameController.dispose();
    _categoryController.dispose();
    _descriptionController.dispose();
    _fullDescriptionController.dispose();
    _serviceDurationController.dispose();
    _priceController.dispose();
    _discountController.dispose();
    _availabilityController.dispose();
    _customAvailabilityController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < stepsImages.length - 1) {
      setState(() {
        _currentStep++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _saveService() {
    print('Service saved!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          label: "Add New Service",
          size: 20.sp,
          color: kGrey400,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Step Image
            Image.asset(stepsImages[_currentStep]),

            SizedBox(height: 16.h),

            // Content Area
            Expanded(
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                controller: _pageController,
                children: [
                  // Step 1: Basic Information
                  _buildStep1Content(),

                  // Step 2: Detailed Information
                  _buildStep2Content(),

                  // Step 3: Pricing
                  _buildStep3Content(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep1Content() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(12.r),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RoundedTextField(
            label: "Service Name:",
            obscureText: false,
            keyboardType: TextInputType.name,
            controller: _serviceNameController,
            fillColor: Color(0xffF3F4F9),
          ),
          SizedBox(height: 16.h),
          RoundedTextField(
            label: "Category Name:",
            obscureText: false,
            keyboardType: TextInputType.name,
            controller: _categoryController,
            fillColor: Color(0xffF3F4F9),
          ),
          SizedBox(height: 16.h),
          CustomText(
            label: "Short Description",
            size: 14.sp,
            fontWeight: FontWeight.w600,
            color: kGrey300,
          ),
          SizedBox(height: 10.h),

          RoundedTextField(
            label: "Enter:",
            obscureText: false,
            keyboardType: TextInputType.name,
            controller: _descriptionController,
            fillColor: Color(0xffF3F4F9),
            maxLines: 3,
          ),

          const Spacer(),

          CircularButton(
            buttonColor: kPrimary,
            buttonText: "Next",
            onPressed: _nextStep,
            width: double.infinity,
          ),
        ],
      ),
    );
  }

  Widget _buildStep2Content() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            label: "Full Description",
            size: 14.sp,
            fontWeight: FontWeight.w600,
            color: kGrey300,
          ),
          SizedBox(height: 10.h),

          RoundedTextField(
            label: "Enter...",
            obscureText: false,
            keyboardType: TextInputType.name,
            controller: _descriptionController,
            fillColor: Color(0xffF3F4F9),
            maxLines: 4,
          ),
          SizedBox(height: 16.h),

          CustomText(
            label: "Upload Images",
            size: 14.sp,
            fontWeight: FontWeight.w600,
            color: kGrey300,
          ),
          SizedBox(height: 8.h),

          // Image Upload Section
          Container(
            height: 110.h,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Container(
              height: 80.h,
              width: width,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 25.r,
                    backgroundColor: kPrimary,
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
          ),
          SizedBox(height: 16.h),
          RoundedTextField(
            label: "Service Duration:",
            obscureText: false,
            keyboardType: TextInputType.name,
            controller: _serviceDurationController,
            fillColor: Color(0xffF3F4F9),
            maxLines: 1,
          ),

          const Spacer(),

          Row(
            children: [
              Expanded(
                child: CircularButton(
                  buttonColor: kSecondary,
                  buttonText: "Back",
                  onPressed: _previousStep,
                  width: double.infinity,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: CircularButton(
                  buttonColor: kPrimary,
                  buttonText: "Next",
                  onPressed: _nextStep,
                  width: double.infinity,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStep3Content() {
    return Container(
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.all(16.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),

            // Price Model Radio Buttons
            CustomText(
              label: "Price Model",
              size: 14.sp,
              fontWeight: FontWeight.w600,
              color: kGrey300,
            ),
            SizedBox(height: 8.h),

            Column(
              children: [
                _buildRadioButton('Per Hour', 'Per Hour'),
                _buildRadioButton('Per Job', 'Per Job'),
                _buildRadioButton('Fixed Package', 'Fixed Package'),
              ],
            ),
            SizedBox(height: 16.h),

            RoundedTextField(
              label: "Price:",
              obscureText: false,
              keyboardType: TextInputType.number,
              controller: _priceController,
              fillColor: Color(0xffF3F4F9),
              maxLines: 1,
            ),
            SizedBox(height: 16.h),

            RoundedTextField(
              label: "Discount/Offers:",
              obscureText: false,
              keyboardType: TextInputType.name,
              controller: _discountController,
              fillColor: Color(0xffF3F4F9),
              maxLines: 1,
            ),

            SizedBox(height: 16.h),
            RoundedTextField(
              label: "Availability:",
              obscureText: false,
              keyboardType: TextInputType.name,
              controller: _availabilityController,
              fillColor: Color(0xffF3F4F9),
              maxLines: 1,
            ),
            SizedBox(height: 16.h),

            RoundedTextField(
              label: "Custom Availability:",
              obscureText: false,
              keyboardType: TextInputType.name,
              controller: _discountController,
              fillColor: Color(0xffF3F4F9),
              maxLines: 1,
            ),
            SizedBox(height: 35.h),
            // const Spacer(),
            Row(
              children: [
                Expanded(
                  child: CircularButton(
                    buttonColor: kSecondary,
                    buttonText: "Back",
                    onPressed: _previousStep,
                    width: double.infinity,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: CircularButton(
                    buttonColor: kPrimary,
                    buttonText: "Save Services",
                    onPressed: _nextStep,
                    width: double.infinity,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioButton(String value, String title) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffF9F7F7),
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.all(2.w),
      margin: EdgeInsets.all(2.w),
      child: Row(
        children: [
          Radio<String>(
            activeColor: kPrimary,
            value: value,
            groupValue: _selectedPriceModel,
            onChanged: (String? newValue) {
              setState(() {
                _selectedPriceModel = newValue!;
              });
            },
          ),
          CustomText(label: title, size: 14.sp, color: Colors.black87),
        ],
      ),
    );
  }
}
