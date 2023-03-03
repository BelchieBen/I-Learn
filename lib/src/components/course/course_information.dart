// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';

/**
 * The Course image and supporting text shown at the top of pages containing the course
 */
class CourseInformation extends StatefulWidget {
  final Map<String, dynamic> course;
  const CourseInformation({
    super.key,
    required this.course,
  });

  @override
  State<CourseInformation> createState() => _CourseInformationState();
}

class _CourseInformationState extends State<CourseInformation> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Image.asset(
          widget.course["image"]!,
          width: 160,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.course["title"]!, style: const TextStyle(fontSize: 18)),
            Text(widget.course["altText"]!),
            const Text("Virtual Online: Not available"),
            const Text("Suitable for everyone"),
          ],
        ),
      ],
    );
  }
}
