import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/screens/providerSide/kitSelection/kit_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Plan {
  final String title;
  final String subtitle;
  final String currentPrice;
  final String oldPrice;
  final List<String> features;
  bool isExpanded;

  Plan({
    required this.title,
    required this.subtitle,
    required this.currentPrice,
    required this.oldPrice,
    required this.features,
    this.isExpanded = false,
  });
}

class _PlanCardHeader extends StatelessWidget {
  final Plan plan;
  final bool isExpanded;
  final Color primaryColor;

  const _PlanCardHeader({
    required this.plan,
    required this.isExpanded,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 36.h,
            width: 36.w,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Appimages.pMembershipIcon),
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // MIDDLE: Title/Subtitle Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  label: plan.title,
                  size: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                SizedBox(height: 2.h),
                CustomText(
                  label: plan.subtitle,
                  size: 12.sp,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),

          // TRAILING: Price/Discount
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Old Price (Cut)
                  CustomText(
                    label: plan.oldPrice,
                    size: 12.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    // decoration: TextDecoration.lineThrough, // Strikethrough
                  ),
                  SizedBox(width: 4.w),
                  // Current Price (Bold and Primary Color)
                  CustomText(
                    label: plan.currentPrice,
                    size: 18.sp,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------

class PlansScreen extends StatefulWidget {
  const PlansScreen({super.key});

  @override
  State<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  int selectedIndex = 0;

  final List<String> tabs = ["Basic", "Platinum", "Royal"];

  final List<Plan> plans = [
    Plan(
      title: "1 Month Plan",
      subtitle: "Perfect for regular service providers",
      currentPrice: "₹300",
      oldPrice: "₹499",
      features: [
        "Feature A: Free delivery",
        "Feature B: 5% off on services",
        "Feature C: 24/7 Chat Support",
      ],
    ),
    Plan(
      title: "3 Month Plan",
      subtitle: "Recommended for growing providers",
      currentPrice: "₹800",
      oldPrice: "₹1299",
      features: [
        "All 1 Month features",
        "Premium Feature D: Priority Booking",
        "Dedicated Account Manager",
      ],
    ),
    Plan(
      title: "6 Month Plan",
      subtitle: "Best value for established providers",
      currentPrice: "₹1500",
      oldPrice: "₹2499",
      features: [
        "All 3 Month features",
        "Exclusive Access to new features",
        "Priority Service & VIP Support",
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

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
          children: [
            Image.asset(
              Appimages.plansPricing,
              height: 150.h,
              width: screenWidth,
            ),
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

            /// Segmented TabBar (Existing code)
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

            SizedBox(height: 20.h),

            // --- 3. EXPANDABLE PLAN CARDS ---
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: plans.length,
                itemBuilder: (context, index) {
                  final plan = plans[index];

                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                        // Border to highlight the expanded card
                        side: plan.isExpanded
                            ? BorderSide.none
                            : BorderSide(color: kPrimary, width: 1.5),
                      ),
                      elevation: 0,
                      child: ExpansionTile(
                        key: PageStorageKey<String>(plan.title),
                        initiallyExpanded: plan.isExpanded,
                        tilePadding: EdgeInsets.symmetric(horizontal: 16.w),

                        onExpansionChanged: (bool expanded) {
                          setState(() {
                            // Collapse all others (Accordion effect)
                            for (var otherPlan in plans) {
                              if (otherPlan != plan) {
                                otherPlan.isExpanded = false;
                              }
                            }
                            plan.isExpanded = expanded;
                          });
                        },

                        // Use the custom header widget for the title content
                        title: _PlanCardHeader(
                          plan: plan,
                          isExpanded: plan.isExpanded,
                          primaryColor: kPrimary,
                        ),

                        // Trailing arrow icon controlled by ExpansionTile
                        trailing: Icon(
                          plan.isExpanded
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          color: kPrimary,
                          size: 28.sp,
                        ),

                        // Expanded Content (Features)
                        children: plan.features.map((feature) {
                          return ListTile(
                            leading: Icon(
                              Icons.check_circle_outline,
                              color: kSecondary,
                              size: 20.sp,
                            ),
                            title: Text(
                              feature,
                              style: TextStyle(fontSize: 14.sp),
                            ),
                            contentPadding: EdgeInsets.only(
                              left: 20.w,
                              right: 10.w,
                            ),
                            dense: true,
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 10.h),

            //explore kit selection
            CircularButton(
              buttonColor: kPrimary,
              buttonText: "Kit Selection",
              onPressed: () => Get.to(() => KitSelectionScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
