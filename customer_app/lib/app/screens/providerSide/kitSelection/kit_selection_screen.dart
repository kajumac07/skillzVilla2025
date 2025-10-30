import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KitSelectionScreen extends StatefulWidget {
  const KitSelectionScreen({super.key});

  @override
  State<KitSelectionScreen> createState() => _KitSelectionScreenState();
}

class _KitSelectionScreenState extends State<KitSelectionScreen> {
  int idCardCount = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAF9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // automaticallyImplyLeading: false,
        title: CustomText(
          label: "Kit Selection",
          size: 18.sp,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==== KIT DETAILS CARD ====
            Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Column(
                children: [
                  _dropdownField("T-Shirt Size :"),
                  _dropdownField("Waist Size :"),
                  _dropdownField("ID Card :"),
                  _quantityField("ID Card :"),
                ],
              ),
            ),

            Spacer(),

            // ==== BILL DETAILS CARD ====
            Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bill Details",
                    style: appStyle(16.sp, kGrey400, FontWeight.w100),
                  ),
                  SizedBox(height: 10.h),
                  _billRow("Uniform", "₹1000"),
                  _billRow("ID Card", "₹200"),
                  _billRow("Cap", "₹200"),
                  const Divider(height: 25),
                  _billRow("Grand Total", "₹1400", isBold: true),
                ],
              ),
            ),

            SizedBox(height: 60.h),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularButton(
          buttonColor: kPrimary,
          buttonText: "Save Service",
          onPressed: () {},
          width: width,
          height: 42.h,
          textSize: 16,
        ),
      ),
    );
  }

  // ==== REUSABLE WIDGETS ====

  Widget _dropdownField(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Container(
        height: 40.h,
        decoration: BoxDecoration(
          color: const Color(0xffF3F4F9),
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 14.sp, color: Colors.black87),
            ),
            const Icon(Icons.arrow_drop_down, color: kGrey400),
          ],
        ),
      ),
    );
  }

  Widget _quantityField(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Container(
        height: 40.h,
        decoration: BoxDecoration(
          color: const Color(0xffF2F2F6),
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 5.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 14.sp, color: Colors.black87),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: kSecondary),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.add, size: 18),
                    onPressed: () {
                      setState(() => idCardCount++);
                    },
                  ),
                  Text(
                    "$idCardCount",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove, size: 18),
                    onPressed: () {
                      if (idCardCount > 1) setState(() => idCardCount--);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _billRow(String title, String amount, {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: appStyle(
              14.sp,
              kGrey300,
              isBold ? FontWeight.bold : FontWeight.w200,
            ),
          ),
          Text(
            amount,
            style: appStyle(
              14.sp,
              kGrey200,
              isBold ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
