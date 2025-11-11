import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/models/product_model.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_divider.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/global/widgets/reuse_text_and_description.dart';
import 'package:customer_app/app/screens/userSide/cart/cart_screen.dart';
import 'package:customer_app/app/screens/userSide/products/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  // Sample product data
  final List<Product> products = [
    Product(
      name: "Intense Bathroom Cleaning",
      price: "\₹455",
      rating: "4.5",
      imageUrl: Appimages.bathroomCleaning,
      subtitle: "Ac Technician",
    ),
    Product(
      name: "Home Interior Walls Painting",
      price: "\₹555",
      rating: "4.8",
      imageUrl: Appimages.homeInterior,
      subtitle: "Ac Technician",
    ),
    Product(
      name: "Swedish Stress Body Massage",
      price: "\₹699",
      rating: "4.3",
      imageUrl: Appimages.bodyMassage,
      subtitle: "Ac Technician",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            /// ---------------- Background Image ----------------
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 190.h,
              child: Image.asset(Appimages.subCategorybgImg, fit: BoxFit.cover),
            ),

            /// ---------------- Back & Profile Buttons ----------------
            Positioned(
              top: 10.h,
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
              top: 10.h,
              right: 16.w,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.notifications_none_rounded, size: 20.sp),
              ),
            ),

            /// ---------------- Main Container ----------------
            Positioned(
              top: 130.h,
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.r),
                      topRight: Radius.circular(10.r),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// ----------Ratings & Time ----------
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "4.8",
                                  style: appStyle(
                                    12.sp,
                                    k232323,
                                    FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  " ⭐ RATINGS",
                                  style: appStyle(
                                    12.sp,
                                    k232323,
                                    FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
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
                                  style: appStyle(
                                    10.sp,
                                    kGrey300,
                                    FontWeight.w200,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),

                        /// ---------- title ----------
                        CustomText(
                          label: "AC Repair & Maintenance",
                          size: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(height: 2.h),
                        CustomText(
                          label: "₹500",
                          size: 17.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        CustomDivider(),
                        SizedBox(height: 2.h),

                        /// ---------- Inclusions Section ----------
                        InclusionsSection(),
                        SizedBox(height: 10.h),

                        /// ---------- Exclusion Section ----------
                        ExclusionsDetails(),
                        SizedBox(height: 10.h),

                        /// ---------- Description Section ----------
                        ProductDescriptionSection(),
                        SizedBox(height: 10.h),

                        ///----------- Prices Section -----------
                        ProductPricesSection(),
                        CustomDivider(),
                        SizedBox(height: 5.h),

                        ///------------ Provide Details Section -----------
                        ProductProviderSection(),

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
                                height:
                                    MediaQuery.of(context).size.height * 0.30,
                                // color: kRed,
                                child: ListView.builder(
                                  itemCount: products.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (ctx, index) {
                                    final pData = products[index];
                                    return GestureDetector(
                                      onTap: () =>
                                          Get.to(() => ProductDetailsScreen()),
                                      child: ProductCard(
                                        bgImage: pData.imageUrl,
                                        price: pData.price,
                                        rating: pData.rating,
                                        title: pData.name,
                                        subtitle: pData.subtitle,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 80.h),
                      ],
                    ),
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
                          "₹500",
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
                      buttonText: "Book Now",
                      onPressed: () => Get.to(() => CartScreen()),
                      width: 150.w,
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

//Product provider section
class ProductProviderSection extends StatelessWidget {
  const ProductProviderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            label: "Provider Information",
            size: 16.sp,
            fontWeight: FontWeight.w600,
            color: kGrey400,
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Container(
                height: 40.h,
                width: 40.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  image: DecorationImage(
                    image: AssetImage(Appimages.rProviderIcon),
                    // fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              CustomText(
                label: "Rahul Sharma",
                size: 14.sp,
                fontWeight: FontWeight.w500,
                color: kGrey300,
              ),
              Spacer(),

              CustomText(
                label: "Know more",
                size: 12.sp,
                fontWeight: FontWeight.bold,
                color: kPrimary,
              ),
            ],
          ),
          SizedBox(height: 10.h),

          Container(
            decoration: BoxDecoration(
              color: surface200,
              borderRadius: BorderRadius.circular(18.r),
            ),

            child: Row(
              children: const [
                Expanded(child: InclusionTile(label: "Background Verified ")),
                Expanded(child: InclusionTile(label: "Trained Professionals")),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          //review and ratings
          Container(
            width: width,
            decoration: BoxDecoration(
              color: Color(0xffF9F9F9),
              borderRadius: BorderRadius.circular(14.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  label: "Reviews & Ratings",
                  size: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: kGrey400,
                ),
                SizedBox(height: 10.h),
                CustomDivider(),
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
                    SizedBox(width: 5.w),
                    Text("|", style: appStyle(12.sp, k232323, FontWeight.bold)),
                    SizedBox(width: 5.w),
                    Text(
                      "100 REVIEWS",
                      style: appStyle(12.sp, k232323, FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TestimonialCard(
                          primary: index.isEven ? kFFF9D1 : kDAFAFF,
                          secondary: index.isEven ? kE2D02A : kSecondary,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//testimonal card
class TestimonialCard extends StatelessWidget {
  const TestimonialCard({
    super.key,
    this.primary = kFFF9D1,
    this.secondary = kE2D02A,
  });
  final Color primary;
  final Color secondary;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          /// --- Main Testimonial Card ---
          Container(
            width: 250.w,
            height: 0.3.sh,
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: secondary, width: 1.2),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "“Great service, quick and clean”",
                  textAlign: TextAlign.center,
                  style: appStyle(14.sp, kDark, FontWeight.w800),
                ),
                SizedBox(height: 4),
                Text(
                  "– Rajesh K.",
                  style: appStyle(12.sp, kDark, FontWeight.w300),
                ),
              ],
            ),
          ),

          /// --- Quote Tab (Top Decorative Box) ---
          Positioned(
            top: 0,
            child: Container(
              width: 170,
              height: 23,
              decoration: BoxDecoration(
                color: secondary,
                border: Border.all(color: secondary),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Center(
                child: Text(
                  "“",
                  style: TextStyle(
                    color: kPrimary,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    height: 0.8,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TabClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final double width = size.width;
    final double height = size.height;
    const double radius = 20.0;
    const double curveDepth = 12.0;

    Path path = Path();

    path.moveTo(0, height - curveDepth);
    path.lineTo(0, radius);
    path.quadraticBezierTo(0, 0, radius, 0);
    path.lineTo(width - radius, 0);
    path.quadraticBezierTo(width, 0, width, radius);
    path.lineTo(width, height - curveDepth);

    // Smooth curved bottom
    path.cubicTo(
      width * 0.8,
      height,
      width * 0.5,
      height,
      width * 0.2,
      height - curveDepth,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
} //product pricises section widget

class ProductPricesSection extends StatelessWidget {
  const ProductPricesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: kSurfaceBg,
        borderRadius: BorderRadius.circular(14.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          CustomText(
            label: "Pricing Details",
            size: 16.sp,
            fontWeight: FontWeight.w600,
            color: kGrey400,
          ),
          SizedBox(height: 8.h),
          CustomDivider(color: c8c8c8),
          SizedBox(height: 8.h),

          /// --- Pricing Options ---
          PricingTile(
            title: "Basic Service",
            price: 500,
            isSelected: true,
            onTap: () {
              // handle selection logic here
            },
          ),
          SizedBox(height: 10.h),
          PricingTile(
            title: "Deep Cleaning",
            price: 600,
            isSelected: false,
            onTap: () {
              // handle selection logic here
            },
          ),
          SizedBox(height: 10.h),
          PricingTile(
            title: "Gas Refill",
            price: 700,
            isSelected: false,
            onTap: () {
              // handle selection logic here
            },
          ),
        ],
      ),
    );
  }
}

//Pricing Tile Widget
class PricingTile extends StatelessWidget {
  final String title;
  final double price;
  final bool isSelected;
  final VoidCallback onTap;

  const PricingTile({
    super.key,
    required this.title,
    required this.price,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// --- Left side: Radio + Title ---
            Row(
              children: [
                Container(
                  width: 20.w,
                  height: 20.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? kPrimary : kGrey200,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: isSelected
                        ? Container(
                            width: 10.w,
                            height: 10.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kPrimary,
                            ),
                          )
                        : const SizedBox(),
                  ),
                ),
                SizedBox(width: 10.w),
                CustomText(
                  label: title,
                  size: 14.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? kPrimary : kGrey300,
                ),
              ],
            ),

            /// --- Right side: Price ---
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              child: Text(
                "₹${price.toStringAsFixed(0)}",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: k232323,
                  fontSize: 18.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//product Description Section Widget
class ProductDescriptionSection extends StatelessWidget {
  const ProductDescriptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 205.h,
      width: width,
      decoration: BoxDecoration(
        color: kSurfaceBg,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        child: Column(
          children: [
            //heading section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  label: "Description",
                  size: 16.sp,
                  fontWeight: FontWeight.normal,
                  color: kGrey400,
                ),
                Icon(Icons.keyboard_arrow_down_sharp, color: kGrey400),
              ],
            ),
            // SizedBox(height: 8.h),
            CustomDivider(color: c8c8c8),
            SizedBox(height: 8.h),
            ReUseRowTextAndDetail(
              title: "Service",
              detail: "Professional AC servicing with filter cleaning",
            ),
            SizedBox(height: 4.h),

            ReUseRowTextAndDetail(
              title: "Works",
              detail: "Gas refill, repair & maintenance options",
            ),
            SizedBox(height: 4.h),

            ReUseRowTextAndDetail(
              title: "Feature",
              detail: "Spare parts cost extra",
            ),
            SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }
}

//Inclusions Section Widget
class InclusionsSection extends StatelessWidget {
  const InclusionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          label: "Inclusions Details",
          size: 16.sp,
          fontWeight: FontWeight.normal,
          color: kPrimary,
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: surface200,
            borderRadius: BorderRadius.circular(18.r),
          ),
          child: Column(
            children: [
              Row(
                children: const [
                  Expanded(child: InclusionTile(label: "Technician Visit")),
                  Expanded(child: InclusionTile(label: "Cleaning")),
                ],
              ),
              const Divider(height: 1, color: Color(0xffffffff)),
              Row(
                children: const [
                  Expanded(child: InclusionTile(label: "Basic Service Tools")),
                  Expanded(child: InclusionTile(label: "Season Service")),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class InclusionTile extends StatelessWidget {
  final String label;
  final String image;
  const InclusionTile({
    required this.label,
    this.image = Appimages.checkIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: const BoxDecoration(
        border: Border(right: BorderSide(color: Color(0xffffffff), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(6.h),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Image.asset(image, width: 20.w, height: 20.w),
          ),
          SizedBox(width: 8.w),
          Flexible(
            child: Text(
              label,
              style: appStyle(14.sp, kGrey400, FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class ExclusionsDetails extends StatelessWidget {
  const ExclusionsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          label: "Exclusions Details",
          size: 16.sp,
          fontWeight: FontWeight.normal,
          color: kSecondary,
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: surface200,
            borderRadius: BorderRadius.circular(18.r),
          ),
          child: Column(
            children: [
              Row(
                children: const [
                  Expanded(
                    child: InclusionTile(
                      label: "XYXXZGHHH",
                      image: Appimages.crossIcon,
                    ),
                  ),
                  Expanded(
                    child: InclusionTile(
                      label: "XYXXZGHHH",
                      image: Appimages.crossIcon,
                    ),
                  ),
                ],
              ),
              const Divider(height: 1, color: Color(0xffffffff)),
              Row(
                children: const [
                  Expanded(
                    child: InclusionTile(
                      label: "XYXXZGHHH",
                      image: Appimages.crossIcon,
                    ),
                  ),
                  Expanded(
                    child: InclusionTile(
                      label: "XYXXZGHHH",
                      image: Appimages.crossIcon,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
