import 'package:booking_app/src/components/course/booking_stepper.dart';
import 'package:flutter/material.dart';

import '../../util/resolve_header_color.dart';

// Page to contain the journey when booking a session
class CourseBookingPage extends StatefulWidget {
  final Map<String, dynamic> course;
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
        backgroundColor: resolveAppHeaderColor());
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

            // The page content is a sub component, the booking stepper. This contains the selectable dates and booking form
            child: BookingStepper(
              course: widget.course,
            ),
          ),
        );
      }),
    );
  }
}
