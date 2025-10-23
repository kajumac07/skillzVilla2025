import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ManageProfileAddressscreens extends StatelessWidget {
  const ManageProfileAddressscreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhite,
        scrolledUnderElevation: 0,
        title: Text(
          'Address',
          style: appStyle(18.sp, k232323, FontWeight.w600),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0.h),
            child: CustomText(
              label: "Select a Address",
              size: 18.sp,
              fontWeight: FontWeight.bold,
              color: kGrey400,
            ),
          ),

          builAddressCard(
            "Home",
            "123, Green Avenue, Sector 21\nChandigarh, Punjab - 16002",
            false,
          ),
          builAddressCard(
            "Work",
            "123, Green Avenue, Sector 21\nChandigarh, Punjab - 16002",
            false,
          ),
          builAddressCard("", "", true),
        ],
      ),
    );
  }

  Widget builAddressCard(String type, String address, bool isNewAddress) {
    return Container(
      margin: EdgeInsets.only(left: 12.w, right: 12.w, top: 8.h),
      padding: EdgeInsets.all(12.h),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          isNewAddress
              ? CustomText(label: "Add a new address")
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(label: type, size: 14.sp, color: kGrey400),
                    Text(
                      address,
                      style: appStyle(12.sp, kGrey200, FontWeight.w200),
                    ),
                  ],
                ),

          Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_horiz_sharp, color: kSecondary),
          ),
        ],
      ),
    );
  }
}
