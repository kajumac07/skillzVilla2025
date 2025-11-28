import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/controller/profile_controller.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ProfileController profileController = Get.find<ProfileController>();
  String selectedSection = 'company';
  final String tabTitle = "Company Details";

  //=======personal details controllers========
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController whatsappController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  //=============bank details controllers========
  final TextEditingController bankAccountController = TextEditingController();
  final TextEditingController confirmBankAccountController =
      TextEditingController();
  final TextEditingController ifscController = TextEditingController();
  final TextEditingController bankPhoneController = TextEditingController();
  final TextEditingController upiController = TextEditingController();
  final TextEditingController branchNameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = profileController.userName;
    phoneController.text = profileController.userPhone;
    whatsappController.text = profileController.userPhone;
    dobController.text = profileController.userModel!.dob;
    emailController.text = profileController.userModel!.email;

    //for bank details
    bankAccountController.text =
        profileController.userModel!.bankDetails.accountNumber;
    confirmBankAccountController.text =
        profileController.userModel!.bankDetails.accountNumber;
    ifscController.text = profileController.userModel!.bankDetails.ifscCode;
    upiController.text = profileController.userModel!.bankDetails.upiId;
    branchNameController.text = profileController.userModel!.bankDetails.branch;
    bankPhoneController.text = profileController.userModel!.bankDetails.phone;
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
                            label: profileController.userName,
                            fontWeight: FontWeight.bold,
                            size: 15.sp,
                          ),
                          CustomText(
                            label: profileController.userPhone,
                            size: 12.sp,
                          ),
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
                          image: NetworkImage(
                            profileController.userModel!.imageUrl,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  // Camera icon (top-right corner)
                  Positioned(
                    top: 32.h,
                    right: 45.w,
                    child: GestureDetector(
                      onTap: () {
                        // show bottom sheet to choose camera / gallery
                        showModalBottomSheet(
                          context: context,
                          builder: (_) => SafeArea(
                            child: Wrap(
                              children: [
                                ListTile(
                                  leading: Icon(Icons.camera_alt),
                                  title: Text('Camera'),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    // call controller: camera
                                    final ProfileController pc =
                                        Get.find<ProfileController>();
                                    pc.pickAndUploadProfileImage(
                                      fromCamera: true,
                                    );
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.photo_library),
                                  title: Text('Gallery'),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    final ProfileController pc =
                                        Get.find<ProfileController>();
                                    pc.pickAndUploadProfileImage(
                                      fromCamera: false,
                                    );
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.close),
                                  title: Text('Cancel'),
                                  onTap: () => Navigator.of(context).pop(),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Image.asset(
                        Appimages.cameraIcon,
                        height: 24.h,
                        width: 44.w,
                      ),
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
        margin: EdgeInsets.symmetric(vertical: 3.h, horizontal: 6.w),
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
          if (profileController.userType == "provider" &&
              profileController.kycType == "company") ...[
            Text(
              "Company Details",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 12.h),
            _inputField(
              controller: nameController,
              label: "Company Name",
              hint: profileController.userName,
            ),
            _dropdownField(label: "Company Type", hint: "Private"),
            _dropdownField(label: "Company Domain", hint: "Manufacturing"),
            SizedBox(height: 18.h),
            Text(
              "POC Details",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 12.h),
            _inputField(
              controller: phoneController,
              label: "Phone",
              hint: profileController.userPhone,
            ),
            _inputField(
              controller: emailController,
              label: "Email",
              hint: "xyz@gmail.com",
            ),
            _dropdownField(label: "Department", hint: "HR"),
            // SizedBox(height: 24.h),
            // _saveButton("Save & Verify"),
          ] else ...[
            Text(
              "Profile Details",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 12.h),
            _inputField(
              controller: nameController,
              label: "Full Name",
              hint: profileController.userName,
            ),
            _inputField(
              controller: phoneController,
              label: "Phone number",
              hint: "9876543456",
            ),
            _inputField(
              controller: whatsappController,
              label: "Whatsapp Number",
              hint: "9876543234",
            ),
            _inputField(
              controller: dobController,
              label: "DOB",
              hint: "DD/MM/YYYY",
            ),
            _inputField(
              controller: emailController,
              label: "Email",
              hint: "john@gmail.com",
            ),
          ],
          SizedBox(height: 20.h),
          _saveButton("Save & Verify"),
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
          _inputField(
            controller: bankAccountController,
            label: "Bank A/C",
            hint: "1234 5678 7890 0000",
          ),
          _inputField(
            controller: confirmBankAccountController,
            label: "Confirm Bank A/C",
            hint: "1234 5678 7890 0000",
          ),
          _inputField(
            controller: ifscController,
            label: "IFSC Code",
            hint: "SBIN0001234",
          ),
          _inputField(
            controller: bankPhoneController,
            label: "Phone",
            hint: profileController.userPhone,
          ),
          _inputField(
            controller: upiController,
            label: "UPI Id",
            hint: "example@upi",
          ),
          _inputField(
            controller: branchNameController,
            label: "Branch Name",
            hint: "Andheri West",
          ),
          _inputField(
            controller: TextEditingController(),
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
          _saveButton(
            profileController.isLoading ? "Saving..." : "Save & Verify",
          ),
        ],
      ),
    );
  }

  // ===== INPUT FIELD WIDGET =====
  Widget _inputField({
    required String label,
    required String hint,
    IconData? suffixIcon,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: TextFormField(
        controller: controller,
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
      onPressed: () async {
        // If bank tab is selected, save bank details
        if (selectedSection == 'bank') {
          final acc = bankAccountController.text;
          final confAcc = confirmBankAccountController.text;
          final ifsc = ifscController.text;
          final phone = bankPhoneController.text.isNotEmpty
              ? bankPhoneController.text
              : profileController.userPhone;
          final upi = upiController.text;
          final branch = branchNameController.text;

          final success = await profileController.updateBankDetails(
            accountNumber: acc,
            confirmAccountNumber: confAcc,
            ifscCode: ifsc,
            phone: phone,
            upiId: upi,
            branch: branch,
            documentUrl: '',
          );

          if (success) {
            // optionally navigate back or show a dialog
            Get.back();
          }
        } else {
          // handle saving company/personal profile fields (if you want)
          // For now show a snackbar
          Get.snackbar(
            'Info',
            'Company/Profile save not implemented',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      },
      height: 42.h,
      width: width,
    );
  }
}
