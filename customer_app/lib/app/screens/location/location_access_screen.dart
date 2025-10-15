import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationAccessScreen extends StatelessWidget {
  const LocationAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            //image section
            Center(
              child: Image.asset(
                Appimages.locatonIcon,
                height: 55.h,
                width: 55.w,
              ),
            ),
            Spacer(),
            CustomText(label: "Where do you want your service"),
            SizedBox(height: 20.h),
            CircularButton(
              buttonColor: kPrimary,
              buttonText: "At my Current Location",
              onPressed: () {},
              width: width,
            ),
            SizedBox(height: 10.h),
            CircularButton(
              buttonColor: greyBtnColor,
              buttonText: "I’ll enter my location manually",
              onPressed: () {},
              width: width,
              textColor: kDark,
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
