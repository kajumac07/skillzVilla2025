import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/screens/location/widgets/at_current_location.dart';
import 'package:customer_app/app/screens/location/widgets/manage_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LocationAccessScreen extends StatelessWidget {
  const LocationAccessScreen({super.key, required this.userType});
  final String userType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
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
            CustomText(
              label: "Where do you want your service",
              size: 18.sp,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 40.h),
            CircularButton(
              buttonColor: kPrimary,
              buttonText: "At my Current Location",
              onPressed: () => Get.to(() => AtCurrentLocationScreen()),
              width: width,
            ),
            SizedBox(height: 10.h),
            CircularButton(
              buttonColor: greyBtnColor,
              buttonText: "I’ll enter my location manually",
              onPressed: () =>
                  Get.to(() => ManageAddressScreen(userType: userType)),
              width: width,
              textColor: kDark,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.022),
          ],
        ),
      ),
    );
  }
}
