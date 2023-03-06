import 'package:booking_app/src/pages/about/about_ld.dart';
import 'package:booking_app/src/pages/about/contact_ld.dart';
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
  const CancelBooking(),
  const AboutLD(),
  const ContactLD(),
];

class PageDestination {
  const PageDestination(this.label, this.icon, this.selectedIcon);

  final String label;
  final Widget icon;
  final Widget selectedIcon;
}

// Core pages shown in the bottom nav bar and top of the side drawer
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

// Pages related to bookings, shown in the side drawer
const List<PageDestination> bookingDestinations = <PageDestination>[
  PageDestination(
      'Register Attendance',
      Icon(Icons.qr_code_scanner_outlined),
      Icon(
        Icons.qr_code_scanner,
        color: Colors.white,
      )),
  PageDestination(
      'Reschedule a Booking',
      Icon(Icons.swap_vert_circle_outlined),
      Icon(
        Icons.swap_vert_circle,
        color: Colors.white,
      )),
  PageDestination(
      'Cancel a Booking',
      Icon(Icons.cancel_schedule_send_outlined),
      Icon(
        Icons.cancel_schedule_send,
        color: Colors.white,
      )),
];
