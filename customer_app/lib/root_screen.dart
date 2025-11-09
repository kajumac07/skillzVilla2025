import 'dart:developer';
import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/services/shared_pref.dart';
import 'package:customer_app/app/screens/providerSide/adsPromotion/ads_promotion.dart';
import 'package:customer_app/app/screens/providerSide/home/pr_home_screen.dart';
import 'package:customer_app/app/screens/providerSide/payoutEarnings/payout_nd_earnings.dart';
import 'package:customer_app/app/screens/providerSide/providerPlans/plans_screen.dart';
import 'package:customer_app/app/screens/userSide/cart/cart_screen.dart';
import 'package:customer_app/app/screens/userSide/home/home_screen.dart';
import 'package:customer_app/app/screens/userSide/myBookings/my_bookings_screen.dart';
import 'package:customer_app/app/screens/userSide/profileScreen/profile_screen.dart';
import 'package:flutter/material.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _currentIndex = 0;
  String? accountType; // Customer or Provider
  String? kycType; // Customer / Freelance / Company
  bool isLoading = true;

  final _sharedPref = AppSharedPrefData();

  // Customer pages
  List<Widget> get _customerPages => [
    const HomeScreen(),
    const ProfileScreen(),
    Container(child: const Center(child: Text("Category Page"))),
    CartScreen(),
    const MyBookingsScreen(),
  ];

  // Provider pages
  List<Widget> get _providerPages => [
    const ProviderHomeScreen(),
    const ProfileScreen(),
    const PlansScreen(),
    const AdsPromotionScreen(),
    const PayoutNdEarningsScreen(),
  ];

  List<Widget> get _pages =>
      accountType == "Customer" ? _customerPages : _providerPages;

  // Customer bottom navigation items
  List<BottomNavigationBarItem> get _customerNavItems => [
    BottomNavigationBarItem(
      icon: Image.asset(
        Appimages.hrIcon,
        width: 24,
        height: 24,
        color: _currentIndex == 0 ? kPrimary : Colors.grey,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Image.asset(
        Appimages.haIcon,
        width: 24,
        height: 24,
        color: _currentIndex == 1 ? kPrimary : Colors.grey,
      ),
      label: 'Account',
    ),
    BottomNavigationBarItem(
      icon: Image.asset(
        Appimages.hcIcon,
        width: 24,
        height: 24,
        color: _currentIndex == 2 ? kPrimary : Colors.grey,
      ),
      label: 'Category',
    ),
    BottomNavigationBarItem(
      icon: Image.asset(
        Appimages.hcaIcon,
        width: 24,
        height: 24,
        color: _currentIndex == 3 ? kPrimary : Colors.grey,
      ),
      label: 'Cart',
    ),
    BottomNavigationBarItem(
      icon: Image.asset(
        Appimages.haBooking,
        width: 24,
        height: 24,
        color: _currentIndex == 4 ? kPrimary : Colors.grey,
      ),
      label: 'Booking',
    ),
  ];

  // Provider bottom navigation items
  List<BottomNavigationBarItem> get _providerNavItems => [
    BottomNavigationBarItem(
      icon: Image.asset(
        Appimages.hrIcon,
        width: 24,
        height: 24,
        color: _currentIndex == 0 ? kPrimary : Colors.grey,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Image.asset(
        Appimages.haIcon,
        width: 24,
        height: 24,
        color: _currentIndex == 1 ? kPrimary : Colors.grey,
      ),
      label: 'Account',
    ),
    BottomNavigationBarItem(
      icon: Image.asset(
        Appimages.planIcon,
        width: 24,
        height: 24,
        color: _currentIndex == 2 ? kPrimary : Colors.grey,
      ),
      label: 'Plans',
    ),
    BottomNavigationBarItem(
      icon: Image.asset(
        Appimages.adsIcon,
        width: 24,
        height: 24,
        color: _currentIndex == 3 ? kPrimary : Colors.grey,
      ),
      label: 'Ads',
    ),
    BottomNavigationBarItem(
      icon: Image.asset(
        Appimages.payoutIcon,
        width: 24,
        height: 24,
        color: _currentIndex == 4 ? kPrimary : Colors.grey,
      ),
      label: 'Payout',
    ),
  ];

  List<BottomNavigationBarItem> get _navItems =>
      accountType == "Customer" ? _customerNavItems : _providerNavItems;

  @override
  void initState() {
    super.initState();
    _loadAccountType();
  }

  Future<void> _loadAccountType() async {
    final userType = await _sharedPref.getUserType();
    final kyc = await _sharedPref.getKycType();

    log("UserType: $userType | KycType: $kyc");

    setState(() {
      accountType = userType ?? "Customer";
      kycType = kyc ?? "Customer";
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() => _currentIndex = index);
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: kPrimary,
          unselectedItemColor: Colors.grey,
          items: _navItems,
        ),
      ),
    );
  }
}
