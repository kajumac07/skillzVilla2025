import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/controller/faq_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FaqController());

    final List<Map<String, String>> faqList = [
      {
        'question': 'How to signup?',
        'answer':
            'To sign up, simply open the app, go to the signup screen, enter your details, and verify your mobile number or email.',
      },
      {
        'question': 'How to do refund?',
        'answer':
            'You can request a refund directly from the “Orders” section. Our team will process your request within 3–5 business days.',
      },
      {
        'question': 'Where I can see the orders?',
        'answer':
            'All your orders are listed in the “My Orders” section on your profile page. You can track, reorder, or cancel them easily.',
      },
      {
        'question': 'How to contact support?',
        'answer':
            'You can reach our support team from the Help & Support section, available in your profile menu.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Faq', style: appStyle(18.sp, k232323, FontWeight.w600)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top gradient section
            Container(
              height: 0.1.sh,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xffFFF4DF),
                    Color(0xffF8DACD),
                    Color(0xffFFCECE),
                  ],
                  stops: [0.0, 0.5, 1.0],
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(child: Image.asset(Appimages.logo, height: 60.h)),
            ),

            SizedBox(height: 24.h),

            // FAQ title
            Text(
              'Frequently Asked Questions',
              style: appStyle(16.sp, k232323, FontWeight.w600),
            ),

            SizedBox(height: 12.h),

            // FAQ list
            Obx(
              () => Column(
                children: List.generate(faqList.length, (index) {
                  final isExpanded = controller.expandedIndex.value == index;
                  final item = faqList[index];

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    margin: EdgeInsets.only(bottom: 8.h),
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(10.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Question row
                        InkWell(
                          borderRadius: BorderRadius.circular(10.r),
                          onTap: () => controller.toggleIndex(index),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 14.h,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    item['question']!,
                                    style: appStyle(
                                      14.sp,
                                      k232323,
                                      FontWeight.w500,
                                    ),
                                  ),
                                ),
                                AnimatedRotation(
                                  duration: const Duration(milliseconds: 300),
                                  turns: isExpanded ? 0.5 : 0,
                                  child: Icon(
                                    Icons.add,
                                    color: kPrimary,
                                    size: 20.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Answer (only visible when expanded)
                        if (isExpanded)
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 8.h,
                            ),
                            child: Text(
                              item['answer']!,
                              style: appStyle(13.sp, k454545, FontWeight.w400),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                      ],
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
