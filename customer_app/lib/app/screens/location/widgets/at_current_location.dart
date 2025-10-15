import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AtCurrentLocationScreen extends StatefulWidget {
  const AtCurrentLocationScreen({super.key});

  @override
  State<AtCurrentLocationScreen> createState() =>
      _AtCurrentLocationScreenState();
}

class _AtCurrentLocationScreenState extends State<AtCurrentLocationScreen> {
  final TextEditingController enterLocationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 40),
            //upper section
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  //text field
                  TextField(
                    controller: enterLocationController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      hintText: "Enter Location",
                      hintStyle: appStyle(14, greyTextColor, FontWeight.w500),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  //location showing
                  Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.all(4),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: locationbgGrey,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: CustomText(
                      label: "Eg. Luxmi Lok Sector24, Panchkula, Haryana",
                      size: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Divider with Or
            Row(
              children: [
                Spacer(),
                Expanded(child: Divider(color: Colors.grey.shade400)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    "Or",
                    style: appStyle(12, greyTextColor, FontWeight.normal),
                  ),
                ),
                Expanded(child: Divider(color: Colors.grey.shade400)),
                Spacer(),
              ],
            ),
            SizedBox(height: 20),
            //outline button
            Container(
              height: 46.h,
              width: width,
              decoration: BoxDecoration(
                color: kWhite,
                border: Border.all(color: kSecondaryLight),
                borderRadius: BorderRadius.circular(22.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage(Appimages.mapIcon)),
                  SizedBox(width: 10.w),
                  CustomText(
                    label: "Use my current location",
                    size: 16,
                    color: kGrey300,
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
