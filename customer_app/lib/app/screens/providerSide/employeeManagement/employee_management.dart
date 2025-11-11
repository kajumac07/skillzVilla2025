import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/screens/providerSide/employeeManagement/widgets/add_employee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EmployeeManagementScreen extends StatefulWidget {
  const EmployeeManagementScreen({super.key});

  @override
  State<EmployeeManagementScreen> createState() =>
      _EmployeeManagementScreenState();
}

class _EmployeeManagementScreenState extends State<EmployeeManagementScreen> {
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
          label: "Employee Management",
          size: 18.sp,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      // body: buildNoEmployees(context),
      body: Column(
        children: [
          //top section
          Container(
            height: 143.h,
            width: width,
            padding: EdgeInsets.all(12.h),
            margin: EdgeInsets.all(12.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              gradient: const LinearGradient(
                colors: [
                  Color(0xffFFF4DF),
                  Color(0xffF8DACD),
                  Color(0xffFFCECE),
                ],
                stops: [0.0, 0.5, 1.0],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(Appimages.logo, height: 85.h, width: 122.w),
                Container(
                  height: 34.h,
                  width: 190.w,
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(22.r),
                  ),
                  child: Center(
                    child: Text(
                      "Company Name",
                      style: appStyle(16.sp, kGrey400, FontWeight.w400),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 10.h),
          //employees lists
          Expanded(child: EmployeesListsCard()),
          Padding(
            padding: EdgeInsets.only(left: 18.0, right: 18, bottom: 10),
            child: CircularButton(
              buttonColor: kPrimary,
              buttonText: "+ Add Employee",
              onPressed: () => Get.to(() => AddEmployeeScreen()),
              height: 40.h,
              width: width,
            ),
          ),
          SizedBox(height: 10.h),
        ],
      ),

      // bottomNavigationBar:
    );
  }

  Widget buildNoEmployees(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(Appimages.empImage, height: 109.h, width: 142.w),
          SizedBox(height: 7.h),
          CustomText(
            label: "No Employees added yet",
            size: 18.sp,
            color: kGrey300,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: 7.h),
          CircularButton(
            buttonColor: kPrimary,
            buttonText: "+",
            onPressed: () {},
            width: MediaQuery.of(context).size.width * 0.5,
          ),
        ],
      ),
    );
  }
}

class EmployeesListsCard extends StatelessWidget {
  const EmployeesListsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> employees = [
      {
        "name": "Rahul Sharma",
        "id": "EMP001",
        "isActive": true,
        "gender": "Male",
      },
      {
        "name": "Manish Sharma",
        "id": "EMP002",
        "isActive": false,
        "gender": "Male",
      },
      {
        "name": "Priya Patel",
        "id": "EMP003",
        "isActive": true,
        "gender": "Female",
      },
      {
        "name": "Vikram Singh",
        "id": "EMP004",
        "isActive": false,
        "gender": "Male",
      },
      {
        "name": "Sneha Iyer",
        "id": "EMP005",
        "isActive": true,
        "gender": "Female",
      },
      {
        "name": "Rajesh Kumar",
        "id": "EMP006",
        "isActive": false,
        "gender": "Male",
      },
    ];

    return Container(
      width: width,
      padding: EdgeInsets.all(12.h),
      margin: EdgeInsets.all(8.h),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            label: "Employees",
            size: 14.sp,
            color: kGrey300,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: 10.h),

          // ✅ Scrollable ListView
          Expanded(
            child: ListView.builder(
              itemCount: employees.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final emp = employees[index];
                return EmployeesListsTile(
                  empName: emp["name"],
                  empId: emp["id"],
                  gender: emp['gender'],
                  isActive: emp["isActive"],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class EmployeesListsTile extends StatelessWidget {
  const EmployeesListsTile({
    super.key,
    required this.empName,
    required this.empId,
    required this.gender,
    required this.isActive,
  });

  final String empName;
  final String empId;
  final String gender;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffF9F7F7),
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.all(10.h),
      margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          height: 44.h,
          width: 44.w,
          decoration: BoxDecoration(
            color: kGrey200,
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              label: empName,
              size: 14.sp,
              color: kGrey400,
              fontWeight: FontWeight.w500,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  label: empId,
                  size: 12.sp,
                  color: kPrimary,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(width: 4.w),
                Container(width: 1.w, height: 14.h, color: kGrey100),
                SizedBox(width: 4.w),
                CustomText(
                  label: gender,
                  size: 12.sp,
                  color: kGrey200,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ],
        ),
        trailing: Column(
          children: [
            CustomText(label: "Cleaner", size: 12.sp, color: kGrey200),
            SizedBox(height: 7.h),
            Container(
              height: 25.h,
              width: 60.w,
              decoration: BoxDecoration(
                color: kWhite,
                border: Border.all(color: isActive ? kSuccess : kGrey200),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 7.h,
                    width: 7.w,
                    decoration: BoxDecoration(
                      color: isActive ? kSuccess : kPrimary,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  SizedBox(width: 2.w),
                  CustomText(
                    label: isActive ? "Active" : "Inactive",
                    size: 10.sp,
                    color: isActive ? kSuccess : kGrey200,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
