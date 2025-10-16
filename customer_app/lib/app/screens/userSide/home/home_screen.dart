import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/global/widgets/rounded_text_field.dart';
import 'package:customer_app/app/screens/userSide/home/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> menus = [
    {"icon": Appimages.searchIcon, "label": "Salon"},
    {"icon": Appimages.searchIcon, "label": "Cleaning"},
    {"icon": Appimages.searchIcon, "label": "Repairs"},
    {"icon": Appimages.searchIcon, "label": "Electrics"},
    {"icon": Appimages.searchIcon, "label": "Painting"},
  ];

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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Header
            buildTopHeader(),
            SizedBox(height: 8.h),
            buildBannerCard(),
            SizedBox(height: 2.h),
            Padding(
              padding: EdgeInsets.only(left: 18.w, top: 18.h, bottom: 10.h),
              child: CustomText(
                label: "Recommended For You",
                size: 18.sp,
                color: kDark,
              ),
            ),
            //recommended product
            Container(
              height: MediaQuery.of(context).size.height * 0.26,
              child: ListView.builder(
                itemCount: products.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  final pData = products[index];
                  return ProductCard(
                    bgImage: pData.imageUrl,
                    price: pData.price,
                    rating: pData.rating,
                    title: pData.name,
                  );
                },
              ),
            ),
            SizedBox(height: 20.h),
            //in the spot light banner
            _buildSpotlightBanner(),
          ],
        ),
      ),
    );
  }

  //spotlight banner
  Widget _buildSpotlightBanner() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Appimages.magicIcon),
            SizedBox(width: 10.w),
            CustomText(
              label: "In The Spotlight",
              size: 20.sp,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(width: 5.w),
            Image.asset(Appimages.magicIcon),
          ],
        ),
        //Image banner
        Container(
          height: 268.h,
          width: width,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(Appimages.spotLight)),
          ),
        ),
      ],
    );
  }

  //build Banner card
  Widget buildBannerCard() {
    return Column(
      children: [
        //banner
        Padding(
          padding: EdgeInsets.only(left: 18.w, right: 18.w, top: 8.h),
          child: Container(
            height: 186.h,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22.r),
              image: DecorationImage(
                image: AssetImage(Appimages.homeBannerImage),
                fit: BoxFit.cover,
              ),
            ),
            clipBehavior: Clip.hardEdge,
            child: Padding(
              padding: EdgeInsets.only(left: 8.w, right: 8.w),
              child: Stack(
                children: [
                  // Girl image positioned to the right
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Image.asset(
                      Appimages.homeBannerGirl,
                      height: 180.h,
                      width: 180.w,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Text content positioned to the left
                  Positioned(
                    left: 20.w,
                    top: 0,
                    bottom: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) {
                            return LinearGradient(
                              colors: [Color(0xffD05506), Color(0xffA93B30)],
                            ).createShader(bounds);
                          },
                          child: Text(
                            "Pampering\nMade Easy",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "Women's salon & spa\nservices, just a tap away",
                          style: appStyle(12, k909090, FontWeight.w300),
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          height: 24.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xffEBDC7C),
                                Color(0xffFFB17D),
                                Color(0xffE65E60),
                              ],
                            ),
                            border: Border.all(color: Color(0xffE65E60)),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Center(
                            child: CustomText(
                              label: "Shop Now",
                              color: kGrey400,
                              size: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        //indicator
        SizedBox(height: 15.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildSliderIndicator(kIndicatorColor),
            SizedBox(width: 5.w),
            buildSliderIndicator(kSurface400),
            SizedBox(width: 5.w),
            buildSliderIndicator(kSurface400),
          ],
        ),
      ],
    );
  }

  //Slider Indicator
  Widget buildSliderIndicator(Color color) {
    return Container(
      height: 6.h,
      width: 17.w,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.r),
      ),
    );
  }

  //=========== Top Header ==================
  Widget buildTopHeader() {
    return Container(
      height: 248.h,
      width: width,
      decoration: BoxDecoration(gradient: kHeaderLinear),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 40.h),
            //top section location, delivery and user icon
            Row(
              children: [
                Spacer(),
                //location
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      label: "Lorem Ipsum",
                      size: 14,
                      fontWeight: FontWeight.bold,
                      color: k909090,
                    ),
                    CustomText(
                      label: "#454,Colony, Noida, Uttar Pradesh",
                      size: 14,
                      fontWeight: FontWeight.w300,
                      color: k424242,
                    ),
                  ],
                ),
                Spacer(),
                // Delivery icon design
                Container(
                  height: 36.h,
                  // width: 60.w,
                  padding: EdgeInsets.only(right: 4.w),
                  decoration: BoxDecoration(
                    color: k212121,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Left gradient/icon section
                      Container(
                        height: 36.h,
                        width: 26.w,
                        margin: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          color: kteal,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(120),
                            topLeft: Radius.circular(20.r),
                            bottomLeft: Radius.circular(25.r),
                            bottomRight: Radius.circular(25.r),
                          ),
                        ),
                        child: Center(
                          child: Image.asset(
                            Appimages.timerIcon,
                            height: 16.h,
                            width: 16.w,
                          ),
                        ),
                      ),
                      SizedBox(width: 3.w),

                      // Text section
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            label: "20",
                            color: kWhite,
                            size: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomText(label: "Mins", color: kWhite, size: 10.sp),
                        ],
                      ),
                    ],
                  ),
                ),

                Spacer(),
                //person icon
                Image.asset(Appimages.personIcon, height: 42.h, width: 42.h),
                Spacer(),
              ],
            ),

            SizedBox(height: 20.h),
            //searchbar
            RoundedTextField(
              label: "Search 'Home Cleaning' ",
              obscureText: false,
              keyboardType: TextInputType.webSearch,
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 12.w, right: 8.w),
                child: Image.asset(
                  Appimages.searchIcon,
                  height: 22.h,
                  width: 22.w,
                ),
              ),
            ),
            //menus
            SizedBox(height: 20.h),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(menus.length, (index) {
                  final item = menus[index];
                  return Padding(
                    padding: EdgeInsets.only(right: 12.w),
                    child: Column(
                      children: [
                        Container(
                          height: 40.h,
                          width: 40.w,
                          padding: EdgeInsets.all(8.w),
                          child: Image.asset(item['icon']),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          item['label'],
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Product {
  final String name;
  final String price;
  final String rating;
  final String imageUrl;

  Product({
    required this.name,
    required this.price,
    required this.rating,
    required this.imageUrl,
  });
}
