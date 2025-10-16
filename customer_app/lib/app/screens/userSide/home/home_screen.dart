import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/global/widgets/rounded_text_field.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Header
            Container(
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
                                  CustomText(
                                    label: "Mins",
                                    color: kWhite,
                                    size: 10.sp,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Spacer(),
                        //person icon
                        Image.asset(
                          Appimages.personIcon,
                          height: 42.h,
                          width: 42.h,
                        ),
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
            ),
          ],
        ),
      ),
    );
  }
}
