import 'package:flutter/material.dart';

class CancelBooking extends StatefulWidget {
  const CancelBooking({super.key});

  @override
  State<CancelBooking> createState() => _CancelBooking();
}

class _CancelBooking extends State<CancelBooking> {
  AppBar appHeader() {
    return AppBar(
      title: const Text("Cancel a Booking"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appHeader(),
      body: const Center(
        child: Text("Cancel Booking"),
      ),
    );
  }
}
