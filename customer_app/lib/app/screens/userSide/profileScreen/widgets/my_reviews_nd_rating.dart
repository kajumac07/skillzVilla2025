import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyReviewsNdRatingScreen extends StatelessWidget {
  const MyReviewsNdRatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhite,
        scrolledUnderElevation: 0,
        title: Text('Wallet', style: appStyle(18.sp, k232323, FontWeight.w600)),
      ),
    );
  }
}
