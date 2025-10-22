import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/models/product_model.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_divider.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/screens/userSide/cart/widgets/address_and_schedule.dart';
import 'package:customer_app/app/screens/userSide/products/product_card.dart';
import 'package:customer_app/app/screens/userSide/products/widgets/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
      appBar: AppBar(title: Text("CART")),

      body: SingleChildScrollView(
        child: Column(
          children: [
            //top offer bar
            Container(
              height: 36.h,
              width: width,
              margin: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                gradient: LinearGradient(
                  colors: [Color(0xffFFFFFF), Color(0xffFFD6C9)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Image.asset(
                      Appimages.checkOffer,
                      height: 24.h,
                      width: 24.w,
                    ),
                    CustomText(
                      label: "You’re saving  ₹15 on this order ",
                      size: 12.sp,
                    ),
                  ],
                ),
              ),
            ),

            //now cart items will be shown here
            Container(
              height: 94.h,
              width: width,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(12.r),
              ),
              margin: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              child: Row(
                children: [
                  //image section
                  Image.asset(
                    Appimages.cartComponent,
                    height: 68.h,
                    width: 68.w,
                  ),
                  SizedBox(width: 5.w),
                  //title and duration and minute
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        label: "AC Repair & Maintenance",
                        size: 14,
                        color: kGrey300,
                      ),
                      SizedBox(height: 2.h),
                      CustomText(
                        label: "Duration: 40-50 mins ",
                        size: 12,
                        color: kGrey200,
                      ),
                      SizedBox(height: 4.h),

                      //time
                      Row(
                        children: [
                          Icon(
                            Icons.timelapse_sharp,
                            size: 14.sp,
                            color: kGreenAccent,
                          ),
                          Text(
                            "20 MINS",
                            style: appStyle(10.sp, kGrey300, FontWeight.w200),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  //price and qty section
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 26.h,
                        width: 60.w,
                        decoration: BoxDecoration(
                          color: kPrimary,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, size: 16.sp, color: kWhite),
                            SizedBox(width: 6.w),
                            CustomText(label: "1", size: 12.sp, color: kWhite),
                            SizedBox(width: 6.w),
                            Icon(Icons.remove, size: 16.sp, color: kWhite),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(),
                          SizedBox(width: 25.w),
                          CustomText(
                            label: "₹500",
                            size: 12.sp,
                            color: k232323,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            ///------------ Recommended for You------------
            Container(
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
                      label: "Recommended For You",
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
                          onTap: () => Get.to(() => ProductDetailsScreen()),
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

            // Spacer(),
            //bottom coupon
            Container(
              height: 48.h,
              width: width,
              margin: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: kWhite,
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Image.asset(Appimages.coupon, height: 24.h, width: 24.w),
                    SizedBox(width: 8.w),
                    CustomText(label: "Use Coupons ", size: 16.sp),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h),
            //pricing details will be here
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
                        CustomText(label: "₹500", size: 14.sp, color: kGrey200),
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
                        CustomText(label: "₹2", size: 14.sp, color: kGrey200),
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
            SizedBox(height: 20.h),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularButton(
          buttonColor: kPrimary,
          buttonText: "Add Address & Slot",
          onPressed: () => Get.to(() => AddressAndSchedule()),
        ),
      ),
    );
  }
}
