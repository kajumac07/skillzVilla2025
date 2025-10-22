import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_divider.dart';
import 'package:customer_app/app/screens/userSide/booking/booking_confirmed_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PayModeScreen extends StatefulWidget {
  const PayModeScreen({super.key});

  @override
  State<PayModeScreen> createState() => _PayModeScreenState();
}

class _PayModeScreenState extends State<PayModeScreen> {
  String? _selectedPaymentOption = 'Google Pay';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PAYMENT',
          style: appStyle(18.sp, k232323, FontWeight.w500),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10),
            buildRecommendedOptions(),
            const SizedBox(height: 25),
            buildScheduleSection(),
            const SizedBox(height: 25),
            buildPayOnDelivery(),
            const SizedBox(height: 25),
            buildBillDetails(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // 1. RECOMMENDED PAYMENT OPTIONS SECTION

  Widget buildRecommendedOptions() {
    return Container(
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(15.r),
      ),
      padding: EdgeInsets.all(16.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recommended Payment Options',
            style: appStyle(16.sp, kGrey300, FontWeight.bold),
          ),
          SizedBox(height: 10.h),
          CustomDivider(),
          buildRadioOption('Google Pay'),

          // Continue Button
          CircularButton(
            buttonColor: kPrimary,
            buttonText: "Continue",
            onPressed: () => Get.to(() => const BookingConfirmedScreen()),
            width: width,
          ),
          // Other Recommended Options
          buildRadioOption('Cash on Delivery'),
          buildRadioOption('PhonePe'),
          buildRadioOption('Paytm'),
        ],
      ),
    );
  }

  // Helper to build the radio options
  Widget buildRadioOption(String title) {
    return RadioListTile<String>(
      title: Text(title, style: appStyle(14.sp, k232323, FontWeight.w500)),
      value: title,
      groupValue: _selectedPaymentOption,
      onChanged: (String? value) {
        setState(() {
          _selectedPaymentOption = value;
        });
      },
      activeColor: kPrimary,
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.zero,
    );
  }

  // 2. SCHEDULE TIME AND DATE SECTION (Expansion Tiles)

  Widget buildScheduleSection() {
    return Container(
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(15.r),
      ),
      padding: EdgeInsets.all(16.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Schedule Time and Date',
            style: appStyle(16.sp, kGrey300, FontWeight.bold),
          ),
          SizedBox(height: 10.h),

          CustomDivider(),

          buildExpansionTile(
            title: 'UPI (Pay via any App)',
            // Custom leading widget for UPI text
            icon: const Text(
              'UPI',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          ),

          buildExpansionTile(
            title: 'Credit/Debit Card',
            subtitle: '3 Offers',
            icon: const Icon(Icons.credit_card, color: Colors.grey),
          ),

          buildExpansionTile(
            title: 'Wallets',
            subtitle: '1 Offer',
            icon: const Icon(
              Icons.account_balance_wallet_outlined,
              color: Colors.grey,
            ),
          ),

          buildExpansionTile(
            title: 'Net Banking',
            icon: const Icon(
              Icons.account_balance_outlined,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  // Helper to build the Expansion Tiles
  Widget buildExpansionTile({
    required String title,
    Widget? icon,
    String? subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      decoration: BoxDecoration(
        color: Color(0xffF9f9f9),
        borderRadius: BorderRadius.circular(15.r),
        // border: Border(
        //   bottom: BorderSide(color: Colors.black12, width: 0.5)),
      ),
      child: ExpansionTile(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: appStyle(14.sp, kGrey300, FontWeight.w500)),
            if (subtitle != null) ...[
              const SizedBox(width: 8),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
        leading: icon != null
            ? Container(
                width: 30, // Aligns the leading icons/text
                alignment: Alignment.centerLeft,
                child: icon,
              )
            : null,
        tilePadding: EdgeInsets.zero,
        // Content for when the tile is expanded
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10),
            child: Text(
              'Placeholder for payment entry form (e.g., card number, expiry date, etc.)',
              style: appStyle(14, kGrey100, FontWeight.w200),
            ),
          ),
        ],
      ),
    );
  }

  // 3. PAY ON DELIVERY OPTION SECTION

  Widget buildPayOnDelivery() {
    return Container(
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(15.r),
      ),
      padding: EdgeInsets.all(16.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pay on Delivery Option',
            style: appStyle(16.sp, kGrey300, FontWeight.bold),
          ),
          SizedBox(height: 10.h),
          CustomDivider(),

          // Cash on Delivery Radio Option (Note: Grouping is shared with the top options)
          RadioListTile<String>(
            title: Text(
              'Cash on Delivery (Cash/UPI)',
              style: appStyle(14.sp, k232323, FontWeight.bold),
            ),
            value: 'Cash on Delivery (Pay on Delivery)',
            groupValue: _selectedPaymentOption,
            onChanged: (String? value) {
              setState(() {
                _selectedPaymentOption = value;
              });
            },
            activeColor: kPrimary,
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  // 4. BILL DETAILS SECTION

  Widget buildBillDetails() {
    // Helper function for invoice rows
    Widget buildDetailRow(
      String title,
      String value, {
      bool isTotal = false,
      bool isDiscount = false,
    }) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: isTotal ? 17 : 16,
                    fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                    color: isTotal
                        ? Colors.black
                        : (isDiscount ? kPrimary : Colors.black87),
                  ),
                ),
                if (isDiscount)
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Text(
                      'Offer applied to your amount',
                      style: TextStyle(
                        fontSize: 12,
                        color: kPrimary,
                        decoration: TextDecoration.underline,
                        decorationColor: kPrimary,
                      ),
                    ),
                  ),
              ],
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: isTotal ? 17 : 16,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                color: isTotal
                    ? Colors.black
                    : (isDiscount ? kPrimary : Colors.black87),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(15.r),
      ),
      padding: EdgeInsets.all(16.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Bill Details',
            style: appStyle(16.sp, k232323, FontWeight.w500),
          ),
          const SizedBox(height: 10),

          buildDetailRow('AC Cleaning', '₹500'),
          buildDetailRow('Discount', '₹2', isDiscount: true),

          const Divider(color: Colors.black45, height: 20),

          buildDetailRow('Grand Total', '₹498', isTotal: true),
        ],
      ),
    );
  }
}
