import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.bgImage,
    required this.price,
    required this.rating,
    required this.title,
    required this.subtitle,
  });

  final String bgImage;
  final String price;
  final String rating;
  final String title;
  final String subtitle;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 18.0.w),
      child: Container(
        // height: 212.h,
        width: 126.w,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //image and add button
            Stack(
              children: [
                //image section
                Container(
                  height: 0.14.sh,
                  width: 127.w,
                  decoration: BoxDecoration(
                    // color: kGreenAccent,
                    image: DecorationImage(
                      image: AssetImage(widget.bgImage),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                //add button
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 36.h,
                    width: 36.w,
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: kPrimary),
                    ),
                    child: Center(child: Icon(Icons.add, color: kPrimary)),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0.w, top: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //price
                  CustomText(
                    label: widget.price,
                    size: 14.sp,
                    color: k232323,
                    fontWeight: FontWeight.w300,
                  ),
                  //rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        Appimages.starIcon,
                        height: 13.5.h,
                        width: 13.5.w,
                      ),
                      CustomText(
                        label: widget.rating,
                        size: 12.sp,
                        color: k232323,
                        fontWeight: FontWeight.w300,
                      ),
                    ],
                  ),
                  //title
                  Text(
                    widget.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: appStyle(12, k454545, FontWeight.w500),
                  ),
                  Text(
                    widget.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: appStyle(12, kGrey100, FontWeight.w500),
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
