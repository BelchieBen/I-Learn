import 'package:booking_app/src/pages/account.dart';
import 'package:booking_app/src/pages/booking/cancel_booking.dart';
import 'package:booking_app/src/pages/home.dart';
import 'package:booking_app/src/pages/booking/my_bookings.dart';
import 'package:booking_app/src/pages/booking/register_attendance.dart';
import 'package:booking_app/src/pages/booking/reschedule_booking.dart';
import 'package:booking_app/src/pages/courses/search_courses.dart';
import 'package:flutter/material.dart';

final List<Widget> pages = <Widget>[
  const Home(),
  const SearchCourses(),
  const MyBookings(),
  const MyAccount(),
  const RegisterAttendance(),
  const RescheduleBooking(),
  const CancelBooking()
];

class PageDestination {
  const PageDestination(this.label, this.icon, this.selectedIcon);

  final String label;
  final Widget icon;
  final Widget selectedIcon;
}

const List<PageDestination> pageDestinations = <PageDestination>[
  PageDestination(
      'Home',
      Icon(Icons.home_outlined),
      Icon(
        Icons.home,
        color: Colors.white,
      )),
  PageDestination(
      'Search',
      Icon(Icons.search_outlined),
      Icon(
        Icons.search,
        color: Colors.white,
      )),
  PageDestination(
      'My Bookings',
      Icon(Icons.collections_bookmark_outlined),
      Icon(
        Icons.collections_bookmark,
        color: Colors.white,
      )),
  PageDestination(
      'Account',
      Icon(Icons.account_circle_outlined),
      Icon(
        Icons.account_circle,
        color: Colors.white,
      )),
];

const List<PageDestination> bookingDestinations = <PageDestination>[
  PageDestination(
      'Register Attendance',
      Icon(Icons.qr_code_scanner_outlined),
      Icon(
        Icons.qr_code_scanner,
        color: Colors.white,
      )),
  PageDestination(
      'Reschedule Booking',
      Icon(Icons.swap_vert_circle_outlined),
      Icon(
        Icons.swap_vert_circle,
        color: Colors.white,
      )),
  PageDestination(
      'Cancel Booking',
      Icon(Icons.cancel_schedule_send_outlined),
      Icon(
        Icons.cancel_schedule_send,
        color: Colors.white,
      )),
];
