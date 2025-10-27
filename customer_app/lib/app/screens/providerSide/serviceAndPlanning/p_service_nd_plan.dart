import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/screens/providerSide/serviceAndPlanning/widgets/add_service_screen.dart';
import 'package:customer_app/app/screens/providerSide/serviceAndPlanning/widgets/service_details_screen.dart';
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
      body: Column(
        children: [
          // Services List
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10.h),
              margin: EdgeInsets.all(12.h),
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    label: "Existing Services",
                    size: 14.sp,
                    color: kGrey300,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 8.h),
                  Expanded(
                    child: ListView.separated(
                      itemCount: 5,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 8.h),
                      itemBuilder: (context, index) => ServicesListTile(
                        serviceName: "Cleaning Service",
                        price: "₹444/hrs",
                        onTap: () {
                          Get.to(
                            () =>
                                ServiceDetailScreen(title: "Cleaning Service"),
                          );
                        },
                        onMoreTap: () {
                          _showServiceOptions(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Add Button
          Container(
            padding: EdgeInsets.all(12.r),
            margin: EdgeInsets.all(12.r),
            child: CircularButton(
              buttonColor: kPrimary,
              buttonText: "+ Add New Service",
              onPressed: () {
                Get.to(() => AddServiceScreen());
              },
              width: width,
            ),
          ),
        ],
      ),
    );
  }

  void _showServiceOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildOptionItem(Icons.edit, "Edit Service", () {
              Get.back();
              // Navigate to edit screen
            }),
            _buildOptionItem(Icons.delete, "Delete Service", () {
              Get.back();
              _showDeleteConfirmation(context);
            }),
            _buildOptionItem(Icons.visibility, "View Details", () {
              Get.back();
              // Navigate to details screen
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionItem(IconData icon, String text, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: kSecondary),
      title: CustomText(label: text, size: 14.sp, color: kGrey300),
      onTap: onTap,
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: CustomText(
          label: "Delete Service",
          size: 16.sp,
          fontWeight: FontWeight.bold,
        ),
        content: CustomText(
          label: "Are you sure you want to delete this service?",
          size: 14.sp,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: CustomText(label: "Cancel", color: kGrey300),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              // Delete service logic
            },
            child: CustomText(label: "Delete", color: Colors.red),
          ),
        ],
      ),
    );
  }
}

class ServicesListTile extends StatelessWidget {
  final String serviceName;
  final String price;
  final VoidCallback onTap;
  final VoidCallback onMoreTap;

  const ServicesListTile({
    super.key,
    required this.serviceName,
    required this.price,
    required this.onTap,
    required this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffF3F4F9),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
        leading: Container(
          height: 42.h,
          width: 42.w,
          decoration: BoxDecoration(
            color: kGrey200,
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              label: serviceName,
              size: 14.sp,
              color: kGrey300,
              fontWeight: FontWeight.w500,
            ),
            CustomText(
              label: price,
              size: 14.sp,
              fontWeight: FontWeight.bold,
              color: kGrey300,
            ),
          ],
        ),
        trailing: IconButton(
          onPressed: onMoreTap,
          icon: Icon(Icons.more_horiz_outlined, color: kSecondary, size: 20.w),
        ),
        onTap: onTap,
      ),
    );
  }
}
