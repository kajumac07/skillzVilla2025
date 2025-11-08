import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OfferChip extends StatelessWidget {
  final String text;
  final String imagePath;
  final Color backgroundColor;

  const OfferChip({
    super.key,
    required this.text,
    required this.imagePath,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      margin: EdgeInsets.only(right: 10.w),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(imagePath, height: 20.h, width: 20.w),
          SizedBox(width: 8.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.black87,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class OfferList extends StatelessWidget {
  const OfferList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> offers = [
      {
        "text": "Big offers on cleaning",
        "image": Appimages.checkOffer,
        "color": kGrey100.withOpacity(0.2),
      },
      {
        "text": "Get 50% off laundry",
        "image": Appimages.coupon,
        "color": kSecondaryLight.withOpacity(0.2),
      },
      {
        "text": "AC repair discount",
        "image": Appimages.checkOffer,
        "color": kPrimary.withOpacity(0.2),
      },
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: offers.map((offer) {
          return OfferChip(
            text: offer["text"],
            imagePath: offer["image"],
            backgroundColor: offer["color"],
          );
        }).toList(),
      ),
    );
  }
}
