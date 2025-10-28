import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_divider.dart';
import 'package:customer_app/app/global/widgets/rounded_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  String? selectedGender;
  String? selectedRole;
  String? selectedDepartment;
  String? selectedWorkType;
  String? selectedLocation;

  final List<String> genders = ['Male', 'Female', 'Other'];
  final List<String> roles = ['Developer', 'Designer', 'Manager'];
  final List<String> departments = ['Engineering', 'HR', 'Finance'];
  final List<String> workTypes = ['Full Time', 'Part Time', 'Contract'];
  final List<String> locations = ['Bangalore', 'Pune', 'Remote'];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xffF8F9FD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Add Employee",
          style: appStyle(18.sp, Colors.black, FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// PERSONAL INFORMATION SECTION
            _buildSectionCard(
              title: "Personal Information",
              icon: Icons.person_outline,
              children: [
                RoundedTextField(
                  label: "Full Name :",
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  fillColor: Color(0xffF3F4F9),
                ),
                RoundedTextField(
                  label: "Email :",
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  fillColor: Color(0xffF3F4F9),
                ),
                RoundedTextField(
                  label: "Phone Number :",
                  obscureText: false,
                  keyboardType: TextInputType.phone,
                  fillColor: Color(0xffF3F4F9),
                ),
                RoundedTextField(
                  label: "Date of birth :",
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  fillColor: Color(0xffF3F4F9),
                ),
                _buildDropdown(
                  "Gender :",
                  genders,
                  selectedGender,
                  (val) => setState(() => selectedGender = val),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            /// EMPLOYMENT DETAILS SECTION
            _buildSectionCard(
              title: "Employment Details",
              icon: Icons.work_outline,
              children: [
                RoundedTextField(
                  label: "Employee ID:",
                  obscureText: false,
                  keyboardType: TextInputType.streetAddress,
                  fillColor: Color(0xffF3F4F9),
                ),
                _buildDropdown(
                  "Role / Position :",
                  roles,
                  selectedRole,
                  (val) => setState(() => selectedRole = val),
                ),
                _buildDropdown(
                  "Department :",
                  departments,
                  selectedDepartment,
                  (val) => setState(() => selectedDepartment = val),
                ),
                _buildDropdown(
                  "Work Type :",
                  workTypes,
                  selectedWorkType,
                  (val) => setState(() => selectedWorkType = val),
                ),
                RoundedTextField(
                  label: "Joining Date :",
                  obscureText: false,
                  keyboardType: TextInputType.datetime,
                  fillColor: Color(0xffF3F4F9),
                ),
                _buildDropdown(
                  "Work Location :",
                  locations,
                  selectedLocation,
                  (val) => setState(() => selectedLocation = val),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            /// IDENTIFICATION DOCUMENTS SECTION
            _buildSectionCard(
              title: "Identification Documents",
              icon: Icons.insert_drive_file_outlined,
              children: [
                _buildUploadField("Govt. ID Proof"),
                _buildUploadField("Address Proof"),
                _buildUploadField("Work Permit"),
                _buildUploadField("Background Verification Document"),
              ],
            ),

            SizedBox(height: 16.h),

            //Kit details section
            _buildSectionCard(
              title: "Kit Details",
              icon: Icons.document_scanner_sharp,
              children: [
                RoundedTextField(
                  label: "TShirt Size ",
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  fillColor: Color(0xffF3F4F9),
                ),
                RoundedTextField(
                  label: "Waist Size ",
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  fillColor: Color(0xffF3F4F9),
                ),
                RoundedTextField(
                  label: "Cap ",
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  fillColor: Color(0xffF3F4F9),
                ),
                RoundedTextField(
                  label: "Hoody ",
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  fillColor: Color(0xffF3F4F9),
                ),
                RoundedTextField(
                  label: "Jacket ",
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  fillColor: Color(0xffF3F4F9),
                ),
                RoundedTextField(
                  label: "ID Card ",
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  fillColor: Color(0xffF3F4F9),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            //profile photo
            _buildSectionCard(
              title: "Identification Documents",
              icon: Icons.person,
              children: [_buildUploadField("Profile Photo")],
            ),

            SizedBox(height: 32.h),

            /// ADD BUTTON
            CircularButton(
              buttonColor: kPrimary,
              buttonText: "Save Employee",
              onPressed: () {},
              width: width,
            ),
            CircularButton(
              buttonColor: Color(0xffE3E8EC),
              textColor: kGrey400,
              buttonText: "Cancel",
              onPressed: () {},
              width: width,
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Reusable Section Card
  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: kSecondary),
              SizedBox(width: 8.w),
              Text(title, style: appStyle(16.sp, kSecondary, FontWeight.w600)),
            ],
          ),
          SizedBox(height: 12.h),
          CustomDivider(),
          SizedBox(height: 12.h),

          ...children.map(
            (e) => Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: e,
            ),
          ),
        ],
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

  /// 🔹 Upload Field with Icon
  Widget _buildUploadField(String label) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: const Color(0xffF3F4F9),
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: appStyle(14.sp, kGrey300, FontWeight.w400)),
          const Icon(Icons.cloud_upload_outlined, color: kGrey200),
        ],
      ),
    );
  }
}
