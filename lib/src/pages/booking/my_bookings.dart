import 'package:flutter/material.dart';

class MyBookings extends StatefulWidget {
  const MyBookings({super.key});

  @override
  State<MyBookings> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBookings> {
  @override
  Widget build(BuildContext context) {
    return Text("My Bookings");
  }
}
