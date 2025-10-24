import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CouponCard extends StatelessWidget {
  final Color backgroundColor;
  final String flatOffer;
  final String code;
  final String description;
  final String expires;
  final VoidCallback? onApplyCode;

  const CouponCard({
    super.key,
    required this.backgroundColor,
    required this.flatOffer,
    required this.code,
    required this.description,
    required this.expires,
    this.onApplyCode,
  });

  @override
  Widget build(BuildContext context) {
    final double verticalSectionWidth = 100.w;
    final double cutoutRadius = 15.w;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
      child: Container(
        height: 180.h,
        width: width,
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              left: verticalSectionWidth + 5,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 8.w,
                  top: 8.h,
                  right: 8.w,
                  bottom: 5.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Exclusive Offer',
                          style: appStyle(14.sp, kGrey200, FontWeight.w500),
                        ),
                        // Information icon
                        GestureDetector(
                          onTap: () => _showTermsAndConditions(context),
                          child: Icon(
                            Icons.info_outline,
                            size: 20.sp,
                            color: kDark,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      code,
                      style: appStyle(20.sp, kGrey400, FontWeight.w700),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      description,
                      style: appStyle(14.sp, kGrey400, FontWeight.w400),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      expires,
                      style: appStyle(14.sp, kGrey400, FontWeight.w400),
                    ),
                    const Spacer(),
                    // Apply Code Button
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: onApplyCode,
                        child: Container(
                          width: width,
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 5.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.r),
                            border: Border.all(color: Color(0xffECE7F8)),
                          ),
                          child: Center(
                            child: Text(
                              'Apply Code',
                              style: appStyle(14.sp, kGrey400, FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 2. Vertical Offer Section (Left Side) - The red strip
            Container(
              width: verticalSectionWidth + cutoutRadius - 10.w,
              height: double.infinity,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14.r),
                  bottomLeft: Radius.circular(14.r),
                ),
              ),
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 5.w),
                child: Center(
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      flatOffer,
                      style: appStyle(20.sp, kWhite, FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 0,
              bottom: 0,
              left: -cutoutRadius,
              child: Center(
                child: Container(
                  width: cutoutRadius * 2,
                  height: cutoutRadius * 2,
                  decoration: const BoxDecoration(
                    color: kWhite,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to show the dialog with Terms and Conditions
  void _showTermsAndConditions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          title: Text(
            'Terms and Conditions',
            style: appStyle(18.sp, k232323, FontWeight.w600),
          ),
          content: Text(
            'Offers valid for a limited time. One-time use only. Non-transferable. Terms may vary by service. Subject to change.',
            style: appStyle(14.sp, k232323, FontWeight.w400),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'CLOSE',
                style: appStyle(14.sp, kPrimary, FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }
}
