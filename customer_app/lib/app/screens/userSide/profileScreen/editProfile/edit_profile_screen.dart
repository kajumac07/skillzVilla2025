import 'dart:developer';
import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/services/shared_pref.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String selectedSection = 'company'; // default section
  final _sharedPref = AppSharedPrefData();

  String? userType;
  String? kycType;
  String displayName = "Loading...";
  String displayNumber = "—";
  String tabTitle = "Company Details";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    userType = await _sharedPref.getUserType();
    kycType = await _sharedPref.getKycType();
    log("EditProfileScreen → userType: $userType | kycType: $kycType");

    if (userType == "Customer" && kycType == "Customer") {
      displayName = "Rahul Sharma";
      displayNumber = "9876543210";
    } else if (userType == "Provider" && kycType == "Freelance") {
      displayName = "John Doe";
      displayNumber = "9998887777";
      tabTitle = "Profile Details";
    } else if (userType == "Provider" && kycType == "Company") {
      displayName = "XYZ Company";
      displayNumber = "778899002";
      tabTitle = "Company Details";
    } else {
      displayName = "Guest User";
      displayNumber = "N/A";
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ===== TOP PROFILE SECTION =====
            // ✅ Fixed Top Profile Section (using Stack)
            SizedBox(
              height: 270.h,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Background profile image
                  Positioned(
                    top: 20.h,
                    left: 20.w,
                    right: 20.w,
                    child: Container(
                      height: 224.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(Appimages.profileEditBg),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomText(
                            label: displayName,
                            fontWeight: FontWeight.bold,
                            size: 15.sp,
                          ),
                          CustomText(label: displayNumber, size: 12.sp),
                          SizedBox(height: 25.h),
                        ],
                      ),
                    ),
                  ),

                  // Profile image
                  Positioned(
                    top: 60.h,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 105.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kRed,
                        image: DecorationImage(
                          image: AssetImage(Appimages.profileNew),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),

                  // Camera icon (top-right corner)
                  Positioned(
                    top: 32.h,
                    right: 60.w,
                    child: Image.asset(
                      Appimages.cameraIcon,
                      height: 30.h,
                      width: 24.w,
                    ),
                  ),

                  // Overlapping white card (Wallet, Bookings, Help)
                  Positioned(
                    bottom: -35.h,
                    left: 10.w,
                    right: 10.w,
                    child: Container(
                      height: 78.h,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: kPrimaryLight,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: _tabButton(
                              icon: Icons.person_outline,
                              title: tabTitle,
                              isSelected: selectedSection == 'company',
                              onTap: () =>
                                  setState(() => selectedSection = 'company'),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: _tabButton(
                              icon: Icons.account_balance_outlined,
                              title: "Bank Details",
                              isSelected: selectedSection == 'bank',
                              onTap: () =>
                                  setState(() => selectedSection = 'bank'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40.h),

            // ===== CONTENT SECTION =====
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: selectedSection == 'company'
                  ? _buildCompanyDetails()
                  : _buildBankDetails(),
            ),

            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  // ===== TAB BUTTON =====
  Widget _tabButton({
    required IconData icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 60.h,
        margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 4.w),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFEAEA) : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20.sp,
              color: isSelected ? Colors.redAccent : Colors.black54,
            ),
            SizedBox(height: 4.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.redAccent : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===== COMPANY DETAILS FORM =====
  Widget _buildCompanyDetails() {
    return Container(
      key: const ValueKey('company'),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      margin: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (userType == "Provider" && kycType == "Company") ...[
            Text(
              "Company Details",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 12.h),
            _inputField(label: "Company Name", hint: displayName),
            _dropdownField(label: "Company Type", hint: "Private"),
            _dropdownField(label: "Company Domain", hint: "Manufacturing"),
            SizedBox(height: 18.h),
            Text(
              "POC Details",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 12.h),
            _inputField(label: "Phone", hint: displayNumber),
            _inputField(label: "Email", hint: "xyz@gmail.com"),
            _dropdownField(label: "Department", hint: "HR"),
            SizedBox(height: 24.h),
            _saveButton("Save & Verify"),
          ] else ...[
            Text(
              "Profile Details",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 12.h),
            _inputField(label: "Full Name", hint: displayName),
            _inputField(label: "Phone number", hint: "9876543456"),
            _inputField(label: "Whatsapp Number", hint: "9876543234"),
            _inputField(label: "DOB", hint: "DD/MM/YYYY"),
            _inputField(label: "Email", hint: "john@gmail.com"),
          ],
        ],
      ),
    );
  }

  // ===== BANK DETAILS FORM =====
  Widget _buildBankDetails() {
    return Container(
      key: const ValueKey('bank'),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      margin: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bank Details",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 12.h),
          _inputField(label: "Bank A/C", hint: "1234 5678 7890 0000"),
          _inputField(label: "Confirm Bank A/C", hint: "1234 5678 7890 0000"),
          _inputField(label: "IFSC Code", hint: "SBIN0001234"),
          _inputField(label: "Phone", hint: displayNumber),
          _inputField(label: "UPI Id", hint: "example@upi"),
          _inputField(label: "Branch Name", hint: "Andheri West"),
          _inputField(
            label: "Document Upload",
            hint: "Cancelled Cheque",
            suffixIcon: Icons.upload,
          ),
          SizedBox(height: 10.h),
          Center(
            child: CircularButton(
              height: 36.h,
              width: 190.w,
              buttonColor: kSecondary,
              buttonText: "Upload Bank Account",
              onPressed: () {},
              textSize: 14.sp,
            ),
          ),
          SizedBox(height: 20.h),
          _saveButton("Save & Verify"),
        ],
      ),
    );
  }

  // ===== INPUT FIELD WIDGET =====
  Widget _inputField({
    required String label,
    required String hint,
    IconData? suffixIcon,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          suffixIcon: suffixIcon != null
              ? Icon(suffixIcon, color: Colors.grey)
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical: 10.h,
          ),
        ),
      ),
    );
  }

  Widget _dropdownField({required String label, required String hint}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(hint, style: TextStyle(color: Colors.grey.shade600)),
            const Icon(Icons.arrow_drop_down, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _saveButton(String text) {
    return CircularButton(
      buttonColor: kPrimary,
      buttonText: text,
      onPressed: () {},
      height: 42.h,
      width: width,
    );
  }
}
