import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/screens/userSide/home/home_screen.dart';
import 'package:flutter/material.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _currentIndex = 0;

  // Define your pages/screens
  final List<Widget> _pages = [
    const HomeScreen(),
    const AccountPage(),
    const CategoryPage(),
    const CartPage(),
    const BookingPage(),
  ];

  @override
  Widget build(BuildContext context) {
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
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: kPrimary,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                Appimages.hrIcon,
                width: 24,
                height: 24,
                color: _currentIndex == 0 ? kPrimary : Colors.grey,
              ),
              activeIcon: Image.asset(
                Appimages.hrIcon,
                width: 24,
                height: 24,
                color: kPrimary,
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
              activeIcon: Image.asset(
                Appimages.haIcon,
                width: 24,
                height: 24,
                color: kPrimary,
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
              activeIcon: Image.asset(
                Appimages.hcIcon,
                width: 24,
                height: 24,
                color: kPrimary,
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
              activeIcon: Image.asset(
                Appimages.hcaIcon,
                width: 24,
                height: 24,
                color: kPrimary,
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
              activeIcon: Image.asset(
                Appimages.haBooking,
                width: 24,
                height: 24,
                color: kPrimary,
              ),
              label: 'Booking',
            ),
          ],
        ),
      ),
    );
  }
}

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Account Page'));
  }
}

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Category Page'));
  }
}

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Cart Page'));
  }
}

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Booking Page'));
  }
}
