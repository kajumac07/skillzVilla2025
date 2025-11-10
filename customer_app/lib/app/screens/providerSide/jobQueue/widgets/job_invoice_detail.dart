import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobInvoiceDetailScreen extends StatelessWidget {
  const JobInvoiceDetailScreen({super.key});

  // Helper method to build a detail row
  Widget _buildInfoRow(
    String label,
    String value, {
    bool isBold = false,
    Color? valueColor,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            label: label,
            size: 13.sp,
            color: kGrey200,
            fontWeight: FontWeight.w500,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: CustomText(
              label: value,
              size: 14.sp,
              color: valueColor ?? kGrey200,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Helper method for a light, dashed divider
  Widget _dashedDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final boxWidth = constraints.constrainWidth();
          const dashWidth = 4.0;
          const dashSpace = 4.0;
          final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();
          return Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
            children: List.generate(dashCount, (_) {
              return SizedBox(
                width: dashWidth,
                height: 1.0,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.grey[300]),
                ),
              );
            }),
          );
        },
      ),
    );
  }

  // Helper method for the total row
  Widget _buildTotalRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            label: label,
            size: 14.sp,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
          CustomText(
            label: value,
            size: 14.sp,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: CustomText(
          label: "Invoice",
          size: 18.sp,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              // --- Receipt Card Container ---
              ClipPath(
                clipper: ReceiptClipper(radius: 10.0),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 20.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Header: Booking Info ---
                      Container(
                        height: 0.1.sh,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xffFFF4DF),
                              Color(0xffF8DACD),
                              Color(0xffFFCECE),
                            ],
                            stops: [0.0, 0.5, 1.0],
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Center(
                          child: Image.asset(Appimages.logo, height: 60.h),
                        ),
                      ),

                      Center(
                        child: Column(
                          children: [
                            SizedBox(height: 8.h),
                            CustomText(
                              label: "BK#20250921",
                              size: 12.sp,
                              color: kGrey400,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: 4.h),
                            CustomText(
                              label: "Home Cleaning - 2BHK",
                              size: 20.sp,
                              color: kGrey400,
                              fontWeight: FontWeight.bold,
                              // letterSpacing: 1.5,
                            ),
                            SizedBox(height: 4.h),
                            CustomText(
                              label: "15 Sept 2025, 11:00 AM",
                              size: 10.sp,
                              color: kSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      _dashedDivider(),

                      SizedBox(height: 8.h),
                      _buildInfoRow("Customer :", "Aman Verma"),
                      _buildInfoRow("Place :", "ASilver Springs Apt, Tower C"),

                      _dashedDivider(),

                      // --- Service Provider Info ---
                      CustomText(
                        label: "SERVICE PROVIDER",
                        size: 13.sp,
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(height: 8.h),
                      _buildInfoRow("Service Type :", "Home Cleaning"),
                      _buildInfoRow("Duration :", "2 hrs 30 mins"),
                      _buildInfoRow("Employee :", "2"),

                      _dashedDivider(),

                      // --- Cost Breakdown ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            label: "COST BREAKDOWN",
                            size: 13.sp,
                            color: Colors.black87,
                            fontWeight: FontWeight.w700,
                          ),
                          CustomText(
                            label: "Price",
                            size: 13.sp,
                            color: Colors.black87,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      _buildInfoRow("Service Charges", "₹1,000"),
                      _buildInfoRow("Materials (If any)", "₹150"),
                      _buildInfoRow("Taxes (GST 18%)", "₹216"),

                      SizedBox(height: 8.h),
                      const Divider(thickness: 1, color: Colors.black12),

                      _buildTotalRow("Total Amount", "₹1,366"),

                      _dashedDivider(),

                      // --- Payment Info ---
                      CustomText(
                        label: "PAYMENT INFO",
                        size: 13.sp,
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(height: 8.h),
                      _buildInfoRow("Payment Mode :", "Online - UPI"),
                      _buildInfoRow("Transaction ID :", "TXN_URIRO"),
                      _buildInfoRow(
                        "Payment Status :",
                        "Successful",
                        valueColor: Colors.green,
                        isBold: true,
                      ),
                    ],
                  ),
                ),
              ),

              // --- End of Receipt Card Container ---
              SizedBox(height: 24.h),

              // --- Action Buttons ---
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimary,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  child: CustomText(
                    label: "Download PDF",
                    color: Colors.white,
                    size: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffE3E8EC),
                    elevation: 0,
                    side: BorderSide(color: kGrey400, width: 1),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  child: CustomText(
                    label: "Share",
                    color: Colors.black,
                    size: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Custom Clipper for Receipt Scalloped Edges ---
class ReceiptClipper extends CustomClipper<Path> {
  final double radius; // Radius of the semi-circles

  ReceiptClipper({this.radius = 10.0});

  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(radius, 0); // Start after the first curve

    // Top curves
    for (double i = radius; i < size.width; i += (radius * 2)) {
      if ((i / (radius * 2)).floor() % 2 == 0) {
        // Curve downwards (concave)
        path.arcToPoint(
          Offset(i + radius, 0),
          radius: Radius.circular(radius),
          clockwise: false, // Curve "into" the card
        );
      } else {
        // Curve upwards (convex) - this logic might be adjusted based on desired effect
        // For a more uniform 'cut-in' receipt, we typically only have concave cuts.
        // Let's stick to concave cuts only for a clean receipt look.
        path.arcToPoint(
          Offset(i + radius, 0),
          radius: Radius.circular(radius),
          clockwise: false, // Curve "into" the card
        );
      }
    }

    path.lineTo(
      size.width - radius,
      0,
    ); // Line to the top right corner before the last curve

    // Draw the right side
    path.lineTo(size.width, size.height - radius);

    // Bottom curves
    for (double i = size.width - radius; i > 0; i -= (radius * 2)) {
      if ((i / (radius * 2)).floor() % 2 == 0) {
        // Curve upwards (concave)
        path.arcToPoint(
          Offset(i - radius, size.height),
          radius: Radius.circular(radius),
          clockwise: false, // Curve "into" the card
        );
      } else {
        // Curve downwards (convex) - again, sticking to concave for consistent receipt look
        path.arcToPoint(
          Offset(i - radius, size.height),
          radius: Radius.circular(radius),
          clockwise: false, // Curve "into" the card
        );
      }
    }

    path.lineTo(
      0,
      radius,
    ); // Line to the bottom left corner before the last curve

    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
