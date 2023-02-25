import 'package:flutter/material.dart';

import '../../util/resolve_header_color.dart';

class RescheduleBooking extends StatefulWidget {
  const RescheduleBooking({super.key});

  @override
  State<RescheduleBooking> createState() => _RescheduleBookingState();
}

class _RescheduleBookingState extends State<RescheduleBooking> {
  AppBar appHeader() {
    return AppBar(
      title: const Text("Reschedule a Booking"),
      backgroundColor: resolveAppHeaderColor(),
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
