import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PoliciesScreen extends StatelessWidget {
  const PoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Policies',
          style: appStyle(18.sp, k232323, FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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

            PoliciesLists(title: "Terms and Conditions", onPressed: () {}),
            SizedBox(height: 0.01.sh),
            PoliciesLists(title: "Privacy Policies", onPressed: () {}),
            SizedBox(height: 0.01.sh),
            PoliciesLists(title: "Security Policies", onPressed: () {}),
            SizedBox(height: 0.01.sh),
            PoliciesLists(title: "Terms of use", onPressed: () {}),
          ],
        ),
      ),
    );
  }
}

class PoliciesLists extends StatelessWidget {
  const PoliciesLists({
    super.key,
    required this.title,
    required this.onPressed,
  });
  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.w),
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
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Text(title, style: appStyle(16.sp, kGrey400, FontWeight.w400)),
        trailing: IconButton(
          onPressed: onPressed,
          icon: Icon(Icons.arrow_forward_ios_outlined),
        ),
      ),
    );
  }
}
