import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/models/plan_model.dart';
import 'package:customer_app/app/global/services/payment_service.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomText(
                    label: plan.currentPrice,
                    size: 15.sp,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  // Old Price (Cut)
                  Text(
                    plan.oldPrice,
                    style: appStyle(
                      11.sp,
                      kGrey100,
                      FontWeight.w400,
                    ).copyWith(decoration: TextDecoration.lineThrough),
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
  final List<String> tabs = ["Launch", "Platinum", "Royal"];
  List<bool> expansionStates = [false, false, false];

  List<Plan> get plans {
    return [
      Plan(
        title: "1 Month Plan",
        subtitle: "Perfect for regular service providers",
        currentPrice: "300",
        oldPrice: "499",
        type: tabs[selectedIndex],
        durationInMonths: 1,
        features: [
          "Feature A: Free delivery",
          "Feature B: 5% off on services",
          "Feature C: 24/7 Chat Support",
        ],
        isExpanded: expansionStates[0],
      ),
      Plan(
        title: "3 Month Plan",
        subtitle: "Recommended for growing providers",
        currentPrice: "600",
        oldPrice: "1299",
        type: tabs[selectedIndex],
        durationInMonths: 3,
        features: [
          "All 1 Month features",
          "Premium Feature D: Priority Booking",
          "Dedicated Account Manager",
        ],
        isExpanded: expansionStates[1],
      ),
      Plan(
        title: "6 Month Plan",
        subtitle: "Best value for established providers",
        currentPrice: "1200",
        oldPrice: "2499",
        type: tabs[selectedIndex],
        durationInMonths: 6,
        features: [
          "All 3 Month features",
          "Exclusive Access to new features",
          "Priority Service & VIP Support",
        ],
        isExpanded: expansionStates[2],
      ),
    ];
  }

  void _onExpansionChanged(int index, bool expanded) {
    setState(() {
      // Reset all other expansion states and set current one
      for (int i = 0; i < expansionStates.length; i++) {
        expansionStates[i] = i == index ? expanded : false;
      }
    });
  }

  void _onTabChanged(int index) {
    setState(() {
      selectedIndex = index;
      // Reset expansion states when tab changes
      expansionStates = [false, false, false];
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    PaymentService paymentService = PaymentService(context: context);

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
        padding: EdgeInsets.symmetric(horizontal: 12.w),
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
                      onTap: () => _onTabChanged(index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                        margin: EdgeInsets.symmetric(
                          horizontal: 5.w,
                          vertical: 2.h,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 9.h),
                        decoration: BoxDecoration(
                          color: isSelected ? kSecondary : kWhite,
                          border: Border.all(
                            color: isSelected ? kSecondary : kSecondary,
                          ),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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

            SizedBox(height: 10.h),

            // --- EXPANDABLE PLAN CARDS ---
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: plans.length,
                itemBuilder: (context, index) {
                  final plan = plans[index];

                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                        side: BorderSide(
                          color: plan.isExpanded ? kPrimary : kPrimary,
                          width: 1,
                        ),
                      ),
                      elevation: 0,
                      margin: EdgeInsets.zero,
                      child: Theme(
                        data: Theme.of(
                          context,
                        ).copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          key: PageStorageKey<String>(
                            '${plan.title}-${tabs[selectedIndex]}',
                          ),
                          initiallyExpanded: plan.isExpanded,
                          onExpansionChanged: (bool expanded) {
                            _onExpansionChanged(index, expanded);
                          },
                          title: _PlanCardHeader(
                            plan: plan,
                            isExpanded: plan.isExpanded,
                            primaryColor: kPrimary,
                          ),
                          trailing: Icon(
                            plan.isExpanded
                                ? Icons.keyboard_arrow_up_rounded
                                : Icons.keyboard_arrow_down_rounded,
                            color: kPrimary,
                            size: 28.sp,
                          ),
                          children: [
                            ...plan.features.map((feature) {
                              return ListTile(
                                leading: Icon(
                                  Icons.check_circle,
                                  color: kPrimary,
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
                            SizedBox(height: 10.h),
                            CircularButton(
                              buttonColor: kPrimary,
                              buttonText: "Subscribe",
                              onPressed: () {
                                double amount = double.parse(plan.currentPrice);
                                String packageType = tabs[selectedIndex];

                                paymentService.pay(
                                  amount,
                                  packageType,
                                  plan,
                                  true,
                                );
                              },
                              height: 35.h,
                              width: 320.w,
                            ),
                            SizedBox(height: 10.h),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 10.h),

            // Explore kit selection (commented out)
            // CircularButton(
            //   buttonColor: kPrimary,
            //   buttonText: "Kit Selection",
            //   onPressed: () => Get.to(() => KitSelectionScreen()),
            // ),
          ],
        ),
      ),
    );
  }
}
