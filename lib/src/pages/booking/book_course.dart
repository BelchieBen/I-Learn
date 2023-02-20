import 'package:booking_app/src/components/course/booking_stepper.dart';
import 'package:booking_app/src/components/course/course_information.dart';
import 'package:booking_app/src/components/inputs/date_selector.dart';
import 'package:flutter/material.dart';
import '../../components/forms/booking_form.dart';

class CourseDetail extends StatefulWidget {
  final Map<String, String> course;
  const CourseDetail({
    super.key,
    required this.course,
  });

  @override
  State<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
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
