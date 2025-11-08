import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutSkilzvillaScreen extends StatelessWidget {
  const AboutSkilzvillaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
          style: appStyle(18.sp, k232323, FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🌈 Header gradient container
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

            // 🧾 About section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 6,
                    spreadRadius: 1,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(
                    label: "About SkilzVilla",
                    size: 18.sp,
                    color: k232323,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 12.h),

                  // 🧩 Paragraph 1
                  Text(
                    "At SkilzVilla, we aim to bridge the gap between skilled professionals and customers who need reliable, on-demand services. Whether it’s home maintenance, cleaning, or appliance repair, we bring convenience to your fingertips.",
                    style: appStyle(14.sp, k454545, FontWeight.w400),
                    textAlign: TextAlign.justify,
                  ),

                  SizedBox(height: 10.h),

                  // 🧩 Paragraph 2
                  Text(
                    "Our platform is designed to empower both service providers and customers. We ensure transparency, fair pricing, and verified professionals — so that every task is completed efficiently and with trust.",
                    style: appStyle(14.sp, k454545, FontWeight.w400),
                    textAlign: TextAlign.justify,
                  ),

                  SizedBox(height: 10.h),

                  // 🧩 Paragraph 3
                  Text(
                    "From booking a quick fix to finding a long-term professional, SkilzVilla makes it effortless. With continuous innovation and customer-centric features, we’re redefining how local services work in the digital age.",
                    style: appStyle(14.sp, k454545, FontWeight.w400),
                    textAlign: TextAlign.justify,
                  ),

                  SizedBox(height: 10.h),

                  // 🧩 Paragraph 4
                  Text(
                    "Join us in creating a smarter, more connected service ecosystem — where skill meets opportunity, and customers experience excellence with every booking.",
                    style: appStyle(14.sp, k454545, FontWeight.w400),
                    textAlign: TextAlign.justify,
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
