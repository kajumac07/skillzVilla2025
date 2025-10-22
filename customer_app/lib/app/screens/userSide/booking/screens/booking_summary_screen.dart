import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/models/product_model.dart';
import 'package:customer_app/app/global/widgets/custom_divider.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/screens/userSide/products/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingSummaryScreen extends StatefulWidget {
  const BookingSummaryScreen({super.key});

  @override
  State<BookingSummaryScreen> createState() => _BookingSummaryScreenState();
}

class _BookingSummaryScreenState extends State<BookingSummaryScreen> {
  // Sample product data
  final List<Product> products = [
    Product(
      name: "Intense Bathroom Cleaning",
      price: "\₹455",
      rating: "4.5",
      imageUrl: Appimages.bathroomCleaning,
    ),
    Product(
      name: "Home Interior Walls Painting",
      price: "\₹555",
      rating: "4.8",
      imageUrl: Appimages.homeInterior,
    ),
    Product(
      name: "Swedish Stress Body Massage",
      price: "\₹699",
      rating: "4.3",
      imageUrl: Appimages.bodyMassage,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Booking Summary',
          style: appStyle(18.sp, k232323, FontWeight.w500),
        ),
        // centerTitle: true,
      ),
      body: Column(
        children: [
          builTopSection(context),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                ///------------ Recommended for You------------
                Container(
                  margin: EdgeInsets.only(top: 8.h, left: 16.w, right: 16.w),
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 18.w,
                          top: 18.h,
                          // bottom: 10.h,
                        ),
                        child: CustomText(
                          label: "You may also like",
                          size: 18.sp,
                          color: kDark,
                        ),
                      ),
                      SizedBox(height: 15.h),

                      Container(
                        height: MediaQuery.of(context).size.height * 0.26,
                        child: ListView.builder(
                          itemCount: products.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, index) {
                            final pData = products[index];
                            return GestureDetector(
                              // onTap: () => Get.to(() => ProductDetailsScreen()),
                              child: ProductCard(
                                bgImage: pData.imageUrl,
                                price: pData.price,
                                rating: pData.rating,
                                title: pData.name,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                //------- Bill details section ---------
                Container(
                  height: 170.h,
                  width: width,
                  margin: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          label: "Bill Details",
                          size: 16.sp,
                          color: kGrey400,
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            CustomText(
                              label: "AC Cleaning",
                              size: 14.sp,
                              color: kGrey200,
                            ),
                            Spacer(),
                            CustomText(
                              label: "₹500",
                              size: 14.sp,
                              color: kGrey200,
                            ),
                          ],
                        ),

                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            CustomText(
                              label: "Discount",
                              size: 14.sp,
                              color: kGrey200,
                            ),
                            Spacer(),
                            CustomText(
                              label: "₹2",
                              size: 14.sp,
                              color: kGrey200,
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        CustomText(
                          label: "Offer applied to your amount",
                          size: 10.sp,
                          color: kPrimary,
                        ),
                        SizedBox(height: 5.h),
                        CustomDivider(),
                        Row(
                          children: [
                            CustomText(
                              label: "Grand Total",
                              size: 16.sp,
                              color: k232323,
                              fontWeight: FontWeight.w600,
                            ),
                            Spacer(),
                            CustomText(
                              label: "₹498",
                              size: 16.sp,
                              color: k232323,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget builTopSection(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Stack(
        children: [
          Image(
            image: AssetImage(Appimages.locationBgImage),
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
