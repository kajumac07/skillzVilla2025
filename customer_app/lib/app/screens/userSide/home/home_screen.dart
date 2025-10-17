import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/models/need_today.dart';
import 'package:customer_app/app/global/models/product_model.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/global/widgets/rounded_text_field.dart';
import 'package:customer_app/app/screens/userSide/home/subCategory/sub_category_details_screen.dart';
import 'package:customer_app/app/screens/userSide/home/widgets/need_today_card.dart';
import 'package:customer_app/app/screens/userSide/products/product_card.dart';
import 'package:customer_app/app/screens/userSide/products/widgets/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0;

  final List<Map<String, dynamic>> menus = [
    {"icon": Appimages.searchIcon, "label": "Salon"},
    {"icon": Appimages.searchIcon, "label": "Cleaning"},
    {"icon": Appimages.searchIcon, "label": "Repairs"},
    {"icon": Appimages.searchIcon, "label": "Electrics"},
    {"icon": Appimages.searchIcon, "label": "Painting"},
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

  // Sample need today data
  final List<NeedToday> needToday = [
    NeedToday(
      name: "Water Purifier",
      imageUrl: Appimages.waterPurifier,
      bgImg: Appimages.subCategorybgImg,
    ),
    NeedToday(
      name: "Laptop Service",
      imageUrl: Appimages.laptopService,
      bgImg: Appimages.subCategorybgImg,
    ),
    NeedToday(
      name: "Gardening",
      imageUrl: Appimages.garden,
      bgImg: Appimages.subCategorybgImg,
    ),
    NeedToday(
      name: "Deep Cleaning",
      imageUrl: Appimages.deepClean,
      bgImg: Appimages.subCategorybgImg,
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
            buildBannerCard(),
            SizedBox(height: 2.h),

            // what do you need today
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //headline
                Padding(
                  padding: EdgeInsets.only(left: 18.w, top: 18.h, bottom: 10.h),
                  child: CustomText(
                    label: "What do you need today ?",
                    size: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                //need today product card
                Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: ListView.builder(
                    itemCount: needToday.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, index) {
                      final pData = needToday[index];
                      return GestureDetector(
                        onTap: () => Get.to(
                          () => SubCategoryDetailsScreen(
                            title: pData.name,
                            img: pData.bgImg,
                          ),
                        ),
                        child: NeedTodayCard(
                          image: pData.imageUrl,
                          title: pData.name,
                        ),
                      );
                    },
                  ),
                ),

                // NeedTodayCard(),
              ],
            ),

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
              // color: kRed,
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

            Container(
              height: MediaQuery.of(context).size.height * 0.26,
              // color: kRed,
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

            SizedBox(height: 20.h),
            //more category
            Padding(
              padding: EdgeInsets.only(left: 18.w, top: 18.h, bottom: 10.h),
              child: CustomText(
                label: "More Categories",
                size: 18.sp,
                color: kDark,
              ),
            ),
            SizedBox(height: 10.h),
            //more categories card
            Container(
              height: MediaQuery.of(context).size.height * 0.11,

              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) {
                    return Column(
                      children: [
                        Container(
                          height: 68.h,
                          width: 82.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: kPrimaryLight),
                            color: kWhite,
                          ),
                        ),
                        CustomText(
                          label: "Water Purifier",
                          size: 10.sp,
                          color: kGrey300,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

            //in the spot light banner
            _buildSpotlightBanner(),

            // SizedBox(height: 30.h),
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

  // build Banner Card with Slider
  Widget buildBannerCard() {
    final PageController _pageController = PageController();
    final List<String> bannerImages = [
      Appimages.homeBannerImage,
      Appimages.homeBannerImage,
      Appimages.homeBannerImage,
    ];

    return StatefulBuilder(
      builder: (context, setState) {
        // int _currentPage = 0;

        return Column(
          children: [
            // Banner slider
            Padding(
              padding: EdgeInsets.only(left: 18.w, right: 18.w, top: 8.h),
              child: SizedBox(
                height: 186.h,
                width: width,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: bannerImages.length,
                  onPageChanged: (index) =>
                      setState(() => _currentPage = index),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 2.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22.r),
                        image: DecorationImage(
                          image: AssetImage(bannerImages[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Stack(
                        children: [
                          // Girl image (on right)
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

                          // Text content (on left)
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
                                    return const LinearGradient(
                                      colors: [
                                        Color(0xffD05506),
                                        Color(0xffA93B30),
                                      ],
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
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xffEBDC7C),
                                        Color(0xffFFB17D),
                                        Color(0xffE65E60),
                                      ],
                                    ),
                                    border: Border.all(
                                      color: Color(0xffE65E60),
                                    ),
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
                    );
                  },
                ),
              ),
            ),

            // Indicator
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                bannerImages.length,
                (index) => AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  height: 8.h,
                  width: _currentPage == index ? 24.w : 8.w,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? kIndicatorColor
                        : kSurface400,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  //=========== Top Header ==================
  Widget buildTopHeader() {
    return Container(
      height: 278.h,
      // width: do,
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

            //categories icon
            Container(
              height: 70.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: menus.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (ctx, index) {
                  final item = menus[index];
                  return Padding(
                    padding: EdgeInsets.only(right: 22.w),
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
