import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlansScreen extends StatefulWidget {
  const PlansScreen({super.key});

  @override
  State<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  int selectedIndex = 0;

  final List<String> tabs = ["Basic", "Platinum", "Royal"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: CustomText(
          label: "Active Plan",
          size: 18.sp,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Appimages.plansPricing, height: 150.h, width: width),
            SizedBox(height: 20.h),
            CustomText(
              label: "EXCITING PLANS & PRICING",
              size: 20.sp,
              fontWeight: FontWeight.bold,
              color: kGrey300,
            ),
            SizedBox(height: 2.h),
            CustomText(
              label: "Choose from our three plans",
              size: 14.sp,
              color: kGrey300,
              fontWeight: FontWeight.w300,
            ),
            SizedBox(height: 10.h),

            /// Segmented TabBar
            Container(
              decoration: BoxDecoration(
                color: kSecondaryLight.withOpacity(0.3),
                borderRadius: BorderRadius.circular(40.r),
              ),
              child: Row(
                children: List.generate(tabs.length, (index) {
                  final bool isSelected = selectedIndex == index;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => selectedIndex = index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                        margin: EdgeInsets.symmetric(horizontal: 1.w),
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        decoration: BoxDecoration(
                          color: isSelected ? kSecondary : kWhite,
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 6.w),
                            Text(
                              tabs[index],
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
