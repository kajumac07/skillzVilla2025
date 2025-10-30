import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyReviewsNdRatingScreen extends StatelessWidget {
  const MyReviewsNdRatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Reviews',
          style: appStyle(18.sp, k232323, FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            _buildReviewHeader(),
            SizedBox(height: 15.h),
            _buildRatingQuestionsSection(),
            SizedBox(height: 20.h),
            _buildReviewForm(),
            SizedBox(height: 30.h),
            _buildPreviousReview(),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets for the Design ---

  Widget _buildReviewHeader() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Already centered
        children: [
          _buildProviderInfo(),
          SizedBox(height: 5.h),
          CustomDivider(),
          SizedBox(height: 5.h),
          _buildFeedbackPrompt(), // This is already centered
        ],
      ),
    );
  }

  Widget _buildProviderInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 25.r,
          backgroundImage: const AssetImage(Appimages.providerIcon),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rachel Green',
                style: appStyle(14.sp, kGrey400, FontWeight.bold),
              ),
              Text(
                'Senior Masseuse, Perfect Cleaners',
                style: appStyle(12.sp, kGrey200, FontWeight.w400),
              ),
              Text(
                'ID - #34867777',
                style: appStyle(10.sp, kGrey200, FontWeight.w400),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '22 Aug, 2025',
              style: appStyle(10.sp, kGrey200, FontWeight.w400),
            ),
            Text('10:00 AM', style: appStyle(10.sp, kGrey200, FontWeight.w400)),
          ],
        ),
      ],
    );
  }

  Widget _buildFeedbackPrompt() {
    // The "We value your feedback" section - already centered
    return Center(
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              text: 'We value your feedback',
              style: appStyle(16.sp, kGrey400, FontWeight.w500),
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            'It helps us to improve',
            style: appStyle(12.sp, k343434, FontWeight.w400),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingQuestionsSection() {
    // Contains all the star rating questions - now properly centered
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.center, // Center align the column
        children: [
          _buildRatingQuestion(
            'Did you enjoy the service you received?',
            stars: 4,
          ),
          _buildRatingQuestion(
            'How would you rate the quality of the service?',
            stars: 5,
          ),
          _buildRatingQuestion(
            'Was the service completed on time?',
            stars: 4.5,
          ),
          _buildRatingQuestion("How was the provider's behavior?", stars: 4),
          _buildRatingQuestion("Rate our app experience?", stars: 5),
        ],
      ),
    );
  }

  Widget _buildRatingQuestion(String question, {required double stars}) {
    // A single question and its star rating - now centered
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            question,
            style: appStyle(14.sp, kGrey300, FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),

          // Center the stars row
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Center the stars
            children: List.generate(5, (index) {
              IconData icon = Icons.star;
              Color color = kE2D02A;

              if (index + 1.0 <= stars) {
                icon = Icons.star;
              } else if (index < stars && stars % 1 != 0) {
                icon = Icons.star_half; // Half star
              } else {
                icon = Icons.star_border; // Empty star
                color = Colors.grey.shade300; // Lighter color for empty stars
              }
              return Icon(icon, color: color, size: 30.r);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewForm() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(color: kPrimary),
              boxShadow: [
                BoxShadow(color: kWhite, blurRadius: 5.r, spreadRadius: 2.r),
              ],
            ),
            child: TextField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Write Your Review',
                hintStyle: appStyle(
                  14.sp,
                  Colors.grey.shade500,
                  FontWeight.w400,
                ),
                border: InputBorder.none,
                isDense: true,
              ),
              style: appStyle(14.sp, k232323, FontWeight.w400),
            ),
          ),
          SizedBox(height: 20.h),
          // Submit Button
          CircularButton(
            buttonColor: kPrimary,
            buttonText: "Submit",
            onPressed: () {},
            height: 40.h,
            width: width,
          ),
        ],
      ),
    );
  }

  Widget _buildPreviousReview() {
    // The previous review card at the bottom
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F9FF), // Light background for this section
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Reviewer Image
          CircleAvatar(
            radius: 20.r,
            // Placeholder image
            backgroundImage: AssetImage(Appimages.providerIcon),
          ),
          SizedBox(width: 10.w),
          // Review Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'One of the best massages I\'ve ever had. Pressure was just right and they really focused on my problem areas. Highly recommended!',
                  style: appStyle(13.sp, k232323, FontWeight.w500),
                ),
                SizedBox(height: 5.h),
                // Stars
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      Icons.star,
                      color: const Color(0xFFFFC107),
                      size: 15.r,
                    ),
                  ),
                ),
                SizedBox(height: 5.h),
                // Reviewer Name and Location
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dinesh singh',
                      style: appStyle(
                        11.sp,
                        Colors.grey.shade600,
                        FontWeight.w400,
                      ),
                    ),
                    Text(
                      '22 Aug, 2025',
                      style: appStyle(
                        11.sp,
                        Colors.grey.shade600,
                        FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Mumbai, India',
                  style: appStyle(11.sp, Colors.grey.shade600, FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
