import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/controller/sub_category_controller.dart';
import 'package:customer_app/app/global/models/provider_model.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/screens/userSide/chooseProviderList/widgets/provider_card.dart';
import 'package:customer_app/app/screens/userSide/products/widgets/product_details_screen.dart';
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
  final controller = Get.put(SubCategoryController());

  final List<ProviderModel> providers = [
    ProviderModel(
      name: "Shivam Kumar",
      role: "AC Technician",
      rating: 4.5,
      price: 519,
      oldPrice: 600,
      imageUrl: Appimages.providerIcon,
    ),
    ProviderModel(
      name: "Rahul Sharma",
      role: "AC Technician",
      rating: 4.5,
      price: 519,
      oldPrice: 600,
      imageUrl: Appimages.providerIcon,
    ),
    ProviderModel(
      name: "Amit Singh",
      role: "AC Technician",
      rating: 4.5,
      price: 519,
      oldPrice: 600,
      imageUrl: Appimages.providerIcon,
    ),
    ProviderModel(
      name: "Vivek Yadav",
      role: "AC Technician",
      rating: 4.5,
      price: 519,
      oldPrice: 600,
      imageUrl: Appimages.providerIcon,
    ),

    ProviderModel(
      name: "Anup Singh",
      role: "AC Technician",
      rating: 4.5,
      price: 519,
      oldPrice: 600,
      imageUrl: Appimages.providerIcon,
    ),
    ProviderModel(
      name: "Arpit Pandya",
      role: "AC Technician",
      rating: 4.5,
      price: 519,
      oldPrice: 600,
      imageUrl: Appimages.providerIcon,
    ),
  ];

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
                            // onTap: () => Get.to(() => ChooseProviderLists()),
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

          // ✅ Sidebar with dismiss options
          Obx(() {
            return Stack(
              children: [
                if (controller.showSidebar.value)
                  GestureDetector(
                    onTap: () => controller.toggleSidebar(),
                    child: AnimatedOpacity(
                      opacity: controller.showSidebar.value ? 0.4 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        color: Colors.black,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),

                // 🔹 Sidebar panel itself
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  top: 0,
                  bottom: 0,
                  right: controller.showSidebar.value ? 0 : -220.w,
                  width: 220.w,
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.r),
                        bottomLeft: Radius.circular(16.r),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: const Offset(-2, 0),
                        ),
                      ],
                    ),

                    // 🔹 Sidebar content
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ---- Top Header with Close Button ----
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Providers",
                              style: appStyle(16.sp, k232323, FontWeight.w600),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: Colors.black54,
                              ),
                              onPressed: () => controller.toggleSidebar(),
                            ),
                          ],
                        ),

                        // SizedBox(height: 12.h),

                        // ---- Provider List ----
                        Expanded(
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: providers.length,
                            itemBuilder: (context, index) {
                              final provider = providers[index];
                              final isSelected =
                                  controller.selectedProvider.value == index;
                              return GestureDetector(
                                // onTap: () => controller.selectProvider(index),
                                child: ProviderCard(
                                  provider: provider,
                                  onTap: () =>
                                      Get.to(() => ProductDetailsScreen()),
                                ),
                              );
                            },
                          ),
                        ),

                        // ---- Cancel Button ----
                        Center(
                          child: TextButton(
                            onPressed: () => controller.toggleSidebar(),
                            child: Text(
                              "Cancel",
                              style: appStyle(
                                13.sp,
                                Colors.redAccent,
                                FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),

          /// ---------------- Bottom Price Bar ----------------
          // ✅ Bottom Button Section
          Obx(
            () => AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              left: 0,
              right: 0,
              bottom: controller.showSidebar.value ? -100.h : 0,
              child: _bottomPriceBar(controller),
            ),
          ),

          // ✅ Alternate Bottom Buttons (when provider selected)
          Obx(
            () => AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              left: 0,
              right: 0,
              bottom: controller.selectedProvider.value != null ? 0 : -100.h,
              child: _bottomActionButtons(),
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

  // 🔹 Default Bottom Bar
  Widget _bottomPriceBar(SubCategoryController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: kWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("₹519", style: appStyle(18, k232323, FontWeight.w400)),
              Text(
                "Inclusive of all taxes",
                style: appStyle(10, k454545, FontWeight.w300),
              ),
            ],
          ),
          CircularButton(
            buttonColor: kPrimary,
            buttonText: "Choose Provider",
            onPressed: () => controller.toggleSidebar(),
            width: 150.w,
          ),
        ],
      ),
    );
  }

  // 🔹 After provider selection
  Widget _bottomActionButtons() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: kWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: CircularButton(
              buttonColor: kSurfaceBg,
              buttonText: "Continue Adding Service",
              onPressed: () {},
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: CircularButton(
              buttonColor: kPrimary,
              buttonText: "Proceed to Checkout",
              onPressed: () {},
            ),
          ),
        ],
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
