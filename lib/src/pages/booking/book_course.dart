import 'package:booking_app/src/components/course/booking_stepper.dart';
import 'package:flutter/material.dart';

class CourseBookingPage extends StatefulWidget {
  final Map<String, String> course;
  const CourseBookingPage({
    super.key,
    required this.course,
  });

  @override
  State<CourseBookingPage> createState() => _CourseBookingPageState();
}

class _CourseBookingPageState extends State<CourseBookingPage> {
  AppBar appHeader() {
    return AppBar(
      title: const Text("Book a Session"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appHeader(),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
                maxHeight: viewportConstraints.maxHeight),
            child: BookingStepper(course: widget.course),
          ),
        );
      }),
    );
  }
}
