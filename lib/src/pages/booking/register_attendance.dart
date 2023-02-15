import 'package:flutter/material.dart';

class RegisterAttendance extends StatefulWidget {
  const RegisterAttendance({super.key});

  @override
  State<RegisterAttendance> createState() => _RegisterAttendanceState();
}

class _RegisterAttendanceState extends State<RegisterAttendance> {
  AppBar appHeader() {
    return AppBar(
      title: const Text("Register Attendance"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appHeader(),
      body: const Center(
        child: Text("Register Attendance"),
      ),
    );
  }
}
