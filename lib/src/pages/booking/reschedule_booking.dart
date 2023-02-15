import 'package:flutter/material.dart';

class RescheduleBooking extends StatefulWidget {
  const RescheduleBooking({super.key});

  @override
  State<RescheduleBooking> createState() => _RescheduleBookingState();
}

class _RescheduleBookingState extends State<RescheduleBooking> {
  AppBar appHeader() {
    return AppBar(
      title: const Text("Reschedule a Booking"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appHeader(),
      body: const Center(
        child: Text("Reschedule Booking"),
      ),
    );
  }
}
