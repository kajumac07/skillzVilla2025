import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/global/services/payment_service.dart';
import 'package:customer_app/app/global/widgets/circular_button.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KitSelectionScreen extends StatefulWidget {
  const KitSelectionScreen({super.key});

  @override
  State<KitSelectionScreen> createState() => _KitSelectionScreenState();
}

class _KitSelectionScreenState extends State<KitSelectionScreen> {
  int idCardCount = 1;

  // Dropdown values
  final List<String> tshirtSizes = ['S', 'M', 'L', 'XL', 'XXL', '2XL'];
  final List<String> waistSizes = ['28', '30', '32', '34', '36', '38', '40'];
  final List<String> idCardOptions = ['Standard', 'Premium', 'Laminated'];

  // Selected values
  String? selectedTshirtSize;
  String? selectedWaistSize;
  String? selectedIdCardType;

  // Price constants
  final double uniformPrice = 1000.0;
  final double waistSizePrice = 200.0;
  final double idCardBasePrice = 200.0;

  @override
  void initState() {
    super.initState();
    // Set default values if needed
    selectedTshirtSize = tshirtSizes[0];
    selectedWaistSize = waistSizes[0];
    selectedIdCardType = idCardOptions[0];
  }

  // Calculate total amount dynamically
  double calculateTotalAmount() {
    return uniformPrice + waistSizePrice + (idCardBasePrice * idCardCount);
  }

  // Calculate ID card amount (quantity * base price)
  double calculateIdCardAmount() {
    return idCardBasePrice * idCardCount;
  }

  @override
  Widget build(BuildContext context) {
    final PaymentService paymentService = PaymentService(context: context);

    // Calculate amounts
    final double totalAmount = calculateTotalAmount();
    final double idCardAmount = calculateIdCardAmount();

    return Scaffold(
      backgroundColor: const Color(0xffFAF9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: CustomText(
          label: "Kit Selection",
          size: 18.sp,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==== KIT DETAILS CARD ====
            Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Column(
                children: [
                  _dropdownField(
                    label: "T-Shirt Size :",
                    value: selectedTshirtSize,
                    items: tshirtSizes,
                    onChanged: (value) {
                      setState(() {
                        selectedTshirtSize = value;
                      });
                    },
                  ),
                  _dropdownField(
                    label: "Waist Size :",
                    value: selectedWaistSize,
                    items: waistSizes,
                    onChanged: (value) {
                      setState(() {
                        selectedWaistSize = value;
                      });
                    },
                  ),
                  _dropdownField(
                    label: "ID Card Type :",
                    value: selectedIdCardType,
                    items: idCardOptions,
                    onChanged: (value) {
                      setState(() {
                        selectedIdCardType = value;
                      });
                    },
                  ),
                  _quantityField("ID Card Quantity :"),
                ],
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.2),

            // ==== BILL DETAILS CARD ====
            Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bill Details",
                    style: appStyle(16.sp, kGrey400, FontWeight.w100),
                  ),
                  SizedBox(height: 10.h),
                  _billRow(
                    "Uniform (${selectedTshirtSize ?? 'Not selected'})",
                    "₹${uniformPrice.toStringAsFixed(0)}",
                  ),
                  _billRow(
                    "ID Card (${selectedIdCardType ?? 'Not selected'})",
                    "₹${idCardBasePrice.toStringAsFixed(0)}",
                  ),
                  _billRow(
                    "Waist Size (${selectedWaistSize ?? 'Not selected'})",
                    "₹${waistSizePrice.toStringAsFixed(0)}",
                  ),
                  _billRow(
                    "ID Card Quantity (x$idCardCount)",
                    "₹${idCardAmount.toStringAsFixed(0)}",
                  ),
                  const Divider(height: 25),
                  _billRow(
                    "Grand Total",
                    "₹${totalAmount.toStringAsFixed(0)}",
                    isBold: true,
                  ),
                ],
              ),
            ),

            SizedBox(height: 10.h),
            CircularButton(
              buttonColor: kPrimary,
              buttonText: "Save Kit Selection",
              onPressed: () async {
                // Get the dynamically calculated amount
                double amount = calculateTotalAmount();

                // Validate that all selections are made
                if (selectedTshirtSize == null ||
                    selectedWaistSize == null ||
                    selectedIdCardType == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Please make all selections before proceeding",
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                await paymentService.payForKit(
                  amount,
                  selectedTshirtSize!,
                  selectedWaistSize!,
                  selectedIdCardType!,
                  idCardCount,
                );
              },
              width: width,
              height: 42.h,
              textSize: 16,
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  // ==== REUSABLE WIDGETS ====

  Widget _dropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Container(
        height: 40.h,
        decoration: BoxDecoration(
          color: const Color(0xffF3F4F9),
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 14.sp, color: Colors.black87),
            ),
            Container(
              width: 120.w, // Fixed width for dropdown
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: value,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down, color: kGrey400),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                  items: items.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    );
                  }).toList(),
                  onChanged: onChanged,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _quantityField(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Container(
        height: 40.h,
        decoration: BoxDecoration(
          color: const Color(0xffF2F2F6),
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 14.sp, color: Colors.black87),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: kSecondary),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.add, size: 18),
                    onPressed: () {
                      setState(() => idCardCount++);
                    },
                  ),
                  Text(
                    "$idCardCount",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove, size: 18),
                    onPressed: () {
                      if (idCardCount > 1) setState(() => idCardCount--);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _billRow(String title, String amount, {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: appStyle(
                14.sp,
                kGrey300,
                isBold ? FontWeight.bold : FontWeight.w200,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 10.w),
          Text(
            amount,
            style: appStyle(
              14.sp,
              kGrey200,
              isBold ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
