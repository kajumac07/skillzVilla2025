import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/models/provider_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopProvidersSection extends StatelessWidget {
  const TopProvidersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ProviderModel> providersList = [
      ProviderModel(
        name: "Shivam Kumar",
        role: "AC Technician",
        rating: 4.5,
        price: 519,
        oldPrice: 200,
        imageUrl: Appimages.providerOne,
      ),
      ProviderModel(
        name: "Shivam Kumar",
        role: "AC Technician",
        rating: 4.5,
        price: 519,
        oldPrice: 200,
        imageUrl: Appimages.providerOne,
      ),
      ProviderModel(
        name: "Harish Singh",
        role: "AC Technician",
        rating: 4.5,
        price: 519,
        oldPrice: 200,
        imageUrl: Appimages.providerOne,
      ),
      ProviderModel(
        name: "Shivam Kumar",
        role: "AC Technician",
        rating: 4.5,
        price: 519,
        oldPrice: 200,
        imageUrl: Appimages.providerOne,
      ),
      ProviderModel(
        name: "Shivam Kumar",
        role: "AC Technician",
        rating: 4.5,
        price: 519,
        oldPrice: 200,
        imageUrl: Appimages.providerOne,
      ),
      ProviderModel(
        name: "Harish Singh",
        role: "AC Technician",
        rating: 4.5,
        price: 519,
        oldPrice: 200,
        imageUrl: Appimages.providerOne,
      ),
    ];

    // Split list into two halves
    final firstRow = providersList.take(3).toList();
    final secondRow = providersList.skip(3).take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 12.w, top: 18.h, bottom: 10.h),
          child: Text(
            "Top Providers in your Location",
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // Row 1
        SizedBox(
          height: 0.23.sh,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: firstRow.length,
            padding: EdgeInsets.only(left: 12.w),
            itemBuilder: (ctx, index) {
              return _buildProviderCard(firstRow[index]);
            },
          ),
        ),

        SizedBox(height: 14.h),

        // Row 2
        SizedBox(
          height: 0.23.sh,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: secondRow.length,
            padding: EdgeInsets.only(left: 12.w),
            itemBuilder: (ctx, index) {
              return _buildProviderCard(secondRow[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProviderCard(ProviderModel pData) {
    return GestureDetector(
      // onTap: () => Get.to(() => ProductDetailsScreen()),
      child: Container(
        width: 130.w,
        margin: EdgeInsets.only(right: 14.w),
        decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image + Add Button
            Stack(
              children: [
                Container(
                  height: 120.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(pData.imageUrl),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                Positioned(
                  right: 0.w,
                  bottom: 0.h,
                  child: Container(
                    height: 32.h,
                    width: 32.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: kPrimary, width: 1),
                    ),
                    child: Icon(Icons.add, color: kPrimary, size: 18.sp),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price + Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "₹${pData.price}",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 13.sp),
                          SizedBox(width: 3.w),
                          Text(
                            pData.rating.toString(),
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.black87,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  // Name + Verified
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          pData.name,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Image.asset(
                        Appimages.verifiedIcon,
                        height: 13.h,
                        width: 13.w,
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  // Role
                  Text(
                    pData.role,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
