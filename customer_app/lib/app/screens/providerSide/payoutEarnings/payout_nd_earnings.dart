import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/screens/providerSide/payoutEarnings/widgets/payout_requests.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

class PayoutNdEarningsScreen extends StatefulWidget {
  const PayoutNdEarningsScreen({super.key});

  @override
  State<PayoutNdEarningsScreen> createState() => _PayoutNdEarningsScreenState();
}

class _PayoutNdEarningsScreenState extends State<PayoutNdEarningsScreen> {
  int selectedMonthIndex = 2;

  final List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
  final List<double> earnings = [60, 100, 80, 120, 45, 85];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: CustomText(
          label: "Earning Summary",
          size: 18.sp,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 👤 Profile + Earnings Header
            SizedBox(height: 5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundImage: AssetImage(Appimages.providerIcon),
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ajmal’s",
                          style: appStyle(16.sp, kGrey200, FontWeight.w500),
                        ),
                        Text(
                          "Total Earnings",
                          style: appStyle(14.sp, kDark, FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  "₹24,321.90",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),

            SizedBox(height: 5.h),

            // 📅 Time Filter
            GestureDetector(
              onTap: () => Get.to(() => PayoutRequestsScreen()),
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: Colors.grey.shade100,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Time: This year",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black87,
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down_rounded, size: 20),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),

            // 📊 Chart
            SizedBox(
              height: 260.h,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(
                    show: false,
                    getDrawingHorizontalLine: (value) =>
                        FlLine(color: Colors.grey.shade200, strokeWidth: 1),
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 20,
                        getTitlesWidget: (value, meta) {
                          if (value % 20 == 0 && value <= 120) {
                            return Text(
                              '${value.toInt()}K',
                              style: appStyle(12, kGrey400, FontWeight.w400),
                            );
                          }
                          return const SizedBox();
                        },
                        reservedSize: 35,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index < months.length) {
                            final isActive = selectedMonthIndex == index;
                            return GestureDetector(
                              onTap: () {
                                setState(() => selectedMonthIndex = index);
                              },
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 4.h),
                                    width: 45.w,
                                    height: 17.h,
                                    decoration: isActive
                                        ? BoxDecoration(
                                            color: kPrimary,
                                            borderRadius: BorderRadius.circular(
                                              5.r,
                                            ),
                                          )
                                        : BoxDecoration(),
                                    child: Center(
                                      child: Text(
                                        months[index],
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: isActive
                                              ? FontWeight.w600
                                              : FontWeight.w400,
                                          color: isActive ? kWhite : kGrey200,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  barGroups: List.generate(
                    months.length,
                    (index) => _bar(
                      index,
                      earnings[index],
                      isActive: selectedMonthIndex == index,
                    ),
                  ),
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchCallback:
                        (FlTouchEvent event, barTouchResponse) async {
                          if (barTouchResponse != null &&
                              barTouchResponse.spot != null &&
                              !event.isInterestedForInteractions)
                            return;
                          if (barTouchResponse?.spot != null) {
                            setState(() {
                              selectedMonthIndex =
                                  barTouchResponse!.spot!.touchedBarGroupIndex;
                            });
                          }
                        },
                  ),
                ),
              ),
            ),

            SizedBox(height: 25.h),

            Container(
              width: width,
              padding: EdgeInsets.all(8.r),
              // margin: EdgeInsets.all(4.r),
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 💸 Payouts List
                  Text(
                    "Payouts",
                    style: appStyle(18.sp, kGrey400, FontWeight.bold),
                  ),
                  SizedBox(height: 10.h),
                  _payoutItem("30 Jan 2025", "+ ₹600.000", Colors.green),
                  _payoutItem("24 Jan 2025", "- ₹200.000", Colors.red),
                  _payoutItem("23 Jan 2025", "- ₹745.000", Colors.red),
                  _payoutItem("14 Jan 2025", "+ ₹57.000", Colors.green),
                  _payoutItem("02 Jan 2025", "+ ₹450.000", Colors.green),
                  _payoutItem("14 Jan 2025", "- ₹57.000", Colors.red),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable payout list tile
  Widget _payoutItem(String date, String amount, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            date,
            style: TextStyle(fontSize: 13.sp, color: Colors.black87),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  // Custom bar with better visuals
  BarChartGroupData _bar(int x, double y, {bool isActive = false}) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          width: 26.w, // thicker bars
          borderRadius: BorderRadius.circular(8.r),
          gradient: LinearGradient(
            colors: isActive
                ? [Color(0xffFFBEBF), Color(0xffFFBEBF)]
                : [Color(0xffE3E8EC), Color(0xffE3E8EC)],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
      ],
    );
  }
}
