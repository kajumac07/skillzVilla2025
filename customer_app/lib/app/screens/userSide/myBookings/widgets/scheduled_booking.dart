import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/appStyles.dart';
import 'package:customer_app/app/core/values/app_images.dart';
import 'package:customer_app/app/global/widgets/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

enum BookingStatus { yellow, pink, blue, breakTime }

class Booking {
  final String title;
  final String time;
  final String imageUrl;
  final BookingStatus status;

  Booking(this.title, this.time, this.imageUrl, this.status);
}

class CustomerBookingsScreen extends StatefulWidget {
  const CustomerBookingsScreen({super.key});

  @override
  State<CustomerBookingsScreen> createState() => _CustomerBookingsScreenState();
}

class _CustomerBookingsScreenState extends State<CustomerBookingsScreen> {
  // Current date for the calendar view (Assuming Jan 13, 2025 from screenshot)
  DateTime _selectedDate = DateTime(2025, 10, 13);
  final List<DateTime> _calendarDates = _getDatesForCalendar();

  // --- DUMMY BOOKING DATA ---
  final Map<DateTime, List<Booking>> _bookings = {
    DateTime(2025, 1, 13): [
      Booking(
        'Full Body Massage',
        '08:00 - 08:30 am',
        Appimages.laptopService,
        BookingStatus.yellow,
      ),
      Booking(
        'Full Body Massage',
        '08:00 - 08:30 am',
        Appimages.laptopService,
        BookingStatus.yellow,
      ),
      Booking(
        'Full Body Waxing',
        '09:00 - 09:30 am',
        Appimages.laptopService,

        BookingStatus.pink,
      ),
      Booking(
        'Pedicure Service',
        '10:00 - 10:30 am',
        Appimages.laptopService,
        BookingStatus.blue,
      ),
      // Note: A 'Break' card is inserted directly into the list builder logic
    ],
    // Add more dates and bookings here if needed
    DateTime(2025, 1, 14): [
      Booking(
        'Hair Cut',
        '09:00 - 09:30 am',
        Appimages.providerIcon,
        BookingStatus.pink,
      ),
    ],
  };

  // Helper to generate a range of dates for the calendar
  static List<DateTime> _getDatesForCalendar() {
    List<DateTime> dates = [];
    DateTime startDay = DateTime(
      2025,
      1,
      10,
    ); // Start date approx. 4 days before selected date
    for (int i = 0; i < 7; i++) {
      dates.add(startDay.add(Duration(days: i)));
    }
    return dates;
  }
  // --- END DUMMY BOOKING DATA ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffDAFAFF),
      appBar: AppBar(
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        //   onPressed: () => Navigator.of(context).pop(), // Example navigation
        // ),
        title: Text(
          'My Bookings',
          style: appStyle(18.sp, k232323, FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffFFDADB), Color(0xffDAFAFF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                _buildCalendarHeader(),
                CustomDivider(),
                _buildHorizontalCalendar(),
              ],
            ),
          ),

          const Divider(height: 1, color: Colors.black12),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 12.w, right: 12.w, top: 12.w),
              padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 12.w),
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: _buildBookingList(),
            ),
          ),
        ],
      ),
    );
  }

  // 1. CALENDAR HEADER (Month and Icon)
  Widget _buildCalendarHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateFormat('MMMM yyyy').format(_selectedDate),
            style: appStyle(16.sp, kGrey400, FontWeight.w300),
          ),
          Image.asset(
            Appimages.bookingCalendar,
            height: 24.h,
            width: 24.h,
            color: kGrey300,
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------------
  // 2. HORIZONTAL CALENDAR VIEW
  // ------------------------------------------------------------------
  Widget _buildHorizontalCalendar() {
    return Container(
      height: 90,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _calendarDates.length,
        itemBuilder: (context, index) {
          final date = _calendarDates[index];
          // Check if date is the selected date (ignoring time)
          final isSelected =
              date.day == _selectedDate.day &&
              date.month == _selectedDate.month &&
              date.year == _selectedDate.year;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDate = date;
              });
            },
            child: Container(
              width: 55,
              margin: EdgeInsets.only(
                left: index == 0 ? 16.0 : 4.0,
                right: 4.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('E').format(date)[0], // M, T, W...
                    style: appStyle(12.sp, kGrey200, FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  isSelected
                      ? CircleAvatar(
                          radius: 20,
                          backgroundColor: kPrimary.withOpacity(0.5),
                          child: Text(
                            DateFormat('d').format(date), // Day number
                            style: appStyle(14.sp, kGrey400, FontWeight.w400),
                          ),
                        )
                      : Text(
                          DateFormat('d').format(date), // Day number
                          style: appStyle(14.sp, kGrey400, FontWeight.w400),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // 3. BOOKING LIST

  Widget _buildBookingList() {
    final DateTime keyDate = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
    );
    final bookingsForSelectedDate = _bookings[keyDate] ?? [];

    // Group bookings by time
    final Map<String, List<Booking>> bookingsByTime = {};
    for (final booking in bookingsForSelectedDate) {
      final timeKey = booking.time.split(
        ' ',
      )[0]; // Get "08:00" from "08:00 - 08:30 am"
      if (!bookingsByTime.containsKey(timeKey)) {
        bookingsByTime[timeKey] = [];
      }
      bookingsByTime[timeKey]!.add(booking);
    }

    // Sort time slots
    final sortedTimeSlots = bookingsByTime.keys.toList()
      ..sort((a, b) => a.compareTo(b));

    // The list items, including the date header and the break card
    List<Widget> listItems = [];

    // 1. Date Header
    listItems.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateFormat('EEEE d').format(_selectedDate),
              style: appStyle(16.sp, kGrey400, FontWeight.w500),
            ),
            Text(
              '${bookingsForSelectedDate.length} Visits',
              style: appStyle(16.sp, kPrimary, FontWeight.w500),
            ),
          ],
        ),
      ),
    );

    // 2. Booking and Time Slots - Grouped by time
    for (int i = 0; i < sortedTimeSlots.length; i++) {
      final timeSlot = sortedTimeSlots[i];
      final bookingsAtThisTime = bookingsByTime[timeSlot]!;

      // Time Slot Text (show only once for all bookings at this time)
      listItems.add(
        Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 8.0),
          child: Row(
            children: [
              Text(timeSlot, style: appStyle(16.sp, kGrey400, FontWeight.w500)),
              SizedBox(width: 10.w),
              Expanded(
                child: Container(
                  height: 1.h,
                  width: width,
                  color: Color(0xffCED6DE),
                ),
              ),
            ],
          ),
        ),
      );

      // All Booking Cards for this time slot
      for (final booking in bookingsAtThisTime) {
        listItems.add(_buildBookingCard(booking));
      }

      // Insert the 'Break' card after the second time slot (8:00), matching the screenshot layout
      if (i == 0 && timeSlot == "08:00") {
        // After 8:00 time slot
        listItems.add(
          const Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 8.0),
            child: Text(
              '11:30', // Time before break
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
        );
        listItems.add(_buildBreakCard());
        listItems.add(
          const Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 8.0),
            child: Text(
              '12:00', // Time after break
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
        );
      }
    }

    return ListView(padding: const EdgeInsets.all(16.0), children: listItems);
  }

  // Helper to build individual booking cards
  Widget _buildBookingCard(Booking booking) {
    Color cardColor;
    Color indicatorColor;

    switch (booking.status) {
      case BookingStatus.yellow:
        cardColor = const Color(0xFFFFFADA);
        indicatorColor = Colors.orange.shade300;
        break;
      case BookingStatus.pink:
        cardColor = const Color(0xFFFFDADB);
        indicatorColor = Colors.pink.shade300;
        break;
      case BookingStatus.blue:
        cardColor = const Color(0xFFDAFAFF);
        indicatorColor = Colors.blue.shade300;
        break;
      default:
        cardColor = Colors.white;
        indicatorColor = Colors.grey;
    }

    return Container(
      height: 75.h,
      margin: EdgeInsets.only(bottom: 10.h, left: 50.w),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 12.0.w,
              top: 10.0,
              bottom: 10.0,
              right: 15.0,
            ),
            child: Row(
              children: [
                // Circular image
                CircleAvatar(
                  radius: 28.r,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image.asset(
                      booking.imageUrl,
                      width: 60.w,
                      height: 60.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(width: 15),
                // Booking details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        booking.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 16,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 5),
                          Text(
                            booking.time,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Left-side curved indicator
          // Positioned(
          //   left: 0,
          //   top: 0,
          //   bottom: 0,
          //   child: Container(
          //     width: 15,
          //     decoration: BoxDecoration(
          //       color: indicatorColor,
          //       borderRadius: const BorderRadius.only(
          //         topLeft: Radius.circular(15.0),
          //         bottomLeft: Radius.circular(15.0),
          //         // This is the trick to make it look like a curved edge on the main card
          //         topRight: Radius.circular(10.0),
          //         bottomRight: Radius.circular(10.0),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  // Helper for the "Breakfast break" card
  Widget _buildBreakCard() {
    return Container(
      height: 60,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: Stack(
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Dashed line (using a simplified continuous line)
                Container(width: 30, height: 1, color: Colors.grey),
                const SizedBox(width: 10),
                const Text(
                  'Breakfast break',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(width: 10),
                Container(width: 30, height: 1, color: Colors.grey),
              ],
            ),
          ),
          // Red line indicators at the sides
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 5,
              decoration: BoxDecoration(
                color: Colors.red[300],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 5,
              decoration: BoxDecoration(
                color: Colors.red[300],
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
