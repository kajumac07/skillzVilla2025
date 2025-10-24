import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/models/transaction_models.dart';
import 'package:customer_app/app/global/widgets/custom_text.dart';
import 'package:customer_app/app/global/widgets/icon_tap_image.dart';
import 'package:customer_app/app/screens/notifications/notification_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final List<TransactionModel> dummyTransactions = [
    TransactionModel(
      imageName: Appimages.providerIcon,
      personName: "Tamanna",
      time: "Yesterday 19:12",
      money: "+₹600.00",
    ),
    TransactionModel(
      imageName: Appimages.providerIcon,
      personName: "Rohit Sharma",
      time: "Oct 22, 09:45",
      money: "-₹250.00",
    ),
    TransactionModel(
      imageName: Appimages.providerIcon,
      personName: "Minhaj",
      time: "Oct 21, 14:33",
      money: "+₹120.00",
    ),
    TransactionModel(
      imageName: Appimages.providerIcon,
      personName: "Mayank",
      time: "Oct 20, 08:10",
      money: "-₹499.00",
    ),
    TransactionModel(
      imageName: Appimages.providerIcon,
      personName: "Aditi",
      time: "Oct 19, 20:27",
      money: "-₹320.00",
    ),
    TransactionModel(
      imageName: Appimages.providerIcon,
      personName: "Priya",
      time: "Oct 19, 20:27",
      money: "-₹320.00",
    ),
    TransactionModel(
      imageName: Appimages.providerIcon,
      personName: "Sachin",
      time: "Oct 19, 20:27",
      money: "-₹320.00",
    ),
    TransactionModel(
      imageName: Appimages.providerIcon,
      personName: "SkilzVilla",
      time: "Oct 19, 20:27",
      money: "-₹320.00",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhite,
        scrolledUnderElevation: 0,
        title: Text('Wallet', style: appStyle(18.sp, k232323, FontWeight.w600)),
        actions: [
          SizedBox(width: 10.w),
          TapImageIcon(imageName: Appimages.personIcon, onTap: () {}),
          SizedBox(width: 10.w),
          TapImageIcon(
            imageName: Appimages.notiIcon,
            onTap: () => Get.to(() => NotificationScreens()),
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Appimages.walletBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //info icon
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Spacer(),
                    GestureDetector(
                      onTap: () => _showTermsAndConditions(context),
                      child: Icon(
                        Icons.info_outline,
                        size: 20.sp,
                        color: kDark,
                      ),
                    ),
                  ],
                ),
              ),
              //balance section
              builBalanceSection(),
              //transaction section
              Container(
                margin: EdgeInsets.all(8.h),
                padding: EdgeInsets.all(12.h),
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      label: "Your Transactions",
                      size: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 10.h),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: dummyTransactions.length,
                      itemBuilder: (context, index) {
                        final transaction = dummyTransactions[index];
                        return Padding(
                          padding: EdgeInsets.only(top: 8.0.h, bottom: 8.0.h),
                          child: TransactionListTile(
                            imageName: transaction.imageName,
                            personName: transaction.personName,
                            time: transaction.time,
                            money: transaction.money,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget builBalanceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //balance section
        CustomText(
          label: "Your Balance",
          size: 18.sp,
          color: kGrey200,
          fontWeight: FontWeight.w500,
        ),
        CustomText(
          label: "₹24,321.90",
          size: 32.sp,
          color: kGrey400,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }

  // Function to show the dialog with Terms and Conditions
  void _showTermsAndConditions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          title: Text(
            'Terms and Conditions',
            style: appStyle(18.sp, k232323, FontWeight.w600),
          ),
          content: Text(
            'Offers valid for a limited time. One-time use only. Non-transferable. Terms may vary by service. Subject to change.',
            style: appStyle(14.sp, k232323, FontWeight.w400),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'CLOSE',
                style: appStyle(14.sp, kPrimary, FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }
}

class TransactionListTile extends StatelessWidget {
  const TransactionListTile({
    super.key,
    required this.imageName,
    required this.personName,
    required this.time,
    required this.money,
  });
  final String imageName;
  final String personName;
  final String time;
  final String money;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 28.r,
        child: Image.asset(imageName, height: 60.h, width: 60.w),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(personName, style: appStyle(18.sp, kGrey400, FontWeight.bold)),

          Text(time, style: appStyle(12.sp, kGrey200, FontWeight.w500)),
        ],
      ),
      trailing: CustomText(label: money),
    );
  }
}
