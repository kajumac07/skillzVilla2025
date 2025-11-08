import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/screens/userSide/chooseProviderList/choose_provider_list.dart';
import 'package:customer_app/app/screens/userSide/subCategory/widgets/sub_cat_category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SubCategoryDetailsScreen extends StatefulWidget {
  const SubCategoryDetailsScreen({
    super.key,
    required this.title,
    required this.img,
  });
  final String title;
  final String img;

  @override
  State<SubCategoryDetailsScreen> createState() =>
      _SubCategoryDetailsScreenState();
}

class _SubCategoryDetailsScreenState extends State<SubCategoryDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// ---------------- Background Image ----------------
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 240.h,
            child: Image.asset(widget.img, fit: BoxFit.cover),
          ),

          /// ---------------- Back & Profile Buttons ----------------
          Positioned(
            top: 50.h,
            left: 16.w,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_new, size: 20.sp),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          Positioned(
            top: 50.h,
            right: 16.w,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.share, size: 20.sp),
            ),
          ),

          /// ---------------- Main Container ----------------
          Positioned(
            top: 210.h,
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22.r),
                    topRight: Radius.circular(22.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// ---------- Title & Ratings ----------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          label: widget.title,
                          size: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        Row(
                          children: [
                            Text(
                              "4.8",
                              style: appStyle(12.sp, k232323, FontWeight.bold),
                            ),
                            Text(
                              " ⭐ RATINGS",
                              style: appStyle(12.sp, k232323, FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    /// ---------- Horizontal Chips ----------
                    SizedBox(
                      height: 90.h,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          SubCatCategoryCard(
                            img: widget.img,
                            title: widget.title,
                            isSelected: true,
                          ),
                          SubCatCategoryCard(
                            img: widget.img,
                            title: widget.title,
                            isSelected: false,
                          ),
                          SubCatCategoryCard(
                            img: widget.img,
                            title: widget.title,
                            isSelected: false,
                          ),
                          SubCatCategoryCard(
                            img: widget.img,
                            title: widget.title,
                            isSelected: false,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 10.h),
                    Divider(color: kE9E9E9),
                    SizedBox(height: 10.h),

                    Text(
                      "Repairs",
                      style: appStyle(16.sp, kDark, FontWeight.w400),
                    ),

                    /// ---------- List of Services ----------
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => Get.to(() => ChooseProviderLists()),
                            child: Padding(
                              padding: EdgeInsets.only(
                                bottom: 10.0.h,
                                top: 20.h,
                              ),
                              child: _serviceTile(selected: index == 1),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// ---------------- Bottom Price Bar ----------------
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              decoration: BoxDecoration(color: kWhite),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "₹519",
                        style: appStyle(18, k232323, FontWeight.w400),
                      ),
                      Text(
                        "Inclusive of all taxes",
                        style: appStyle(10, k454545, FontWeight.w300),
                      ),
                    ],
                  ),
                  CircularButton(
                    buttonColor: kPrimary,
                    buttonText: "Choose Provider",
                    onPressed: () {},
                    width: 150.w,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _serviceTile({bool selected = false}) {
    return Container(
      padding: EdgeInsets.all(8.h),
      decoration: BoxDecoration(
        color: selected ? kFFF9D1 : kSurfaceBg,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: ListTile(
        leading: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 70.w,
              height: 80.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            /// Counter box — positioned slightly outside bottom edge, centered horizontally
            Positioned(
              bottom: -8,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("+", style: TextStyle(fontSize: 12)),
                      SizedBox(width: 6.w),
                      const Text(
                        "1",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      const Text("-", style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        title: Text(
          "AC Repairs & Fixing",
          style: appStyle(13.sp, kGrey400, FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("₹519 ", style: appStyle(13, kGrey300, FontWeight.w300)),
                Text("₹519", style: appStyle(13, kGrey100, FontWeight.w300)),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconAndTextCircular(
                  icon: Icons.star,
                  title: "4.5",
                  color: kthemeYellow,
                  isBool: true,
                ),
                SizedBox(width: 10.w),
                IconAndTextCircular(
                  icon: Icons.timelapse_outlined,
                  title: "20 mins",
                  color: kGreenAccent,
                  isBool: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class IconAndTextCircular extends StatelessWidget {
  const IconAndTextCircular({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
    required this.isBool,
  });

  final IconData icon;
  final String title;
  final Color color;
  final bool isBool;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.h,
      width: isBool ? 35.w : 61.w,
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 14),
          Text(title, style: appStyle(10.sp, kGrey300, FontWeight.w300)),
        ],
      ),
    );
  }
}
