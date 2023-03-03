// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

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
  var loggerNoStack = Logger(
    printer: PrettyPrinter(methodCount: 0),
  );

  @override
  Widget build(BuildContext context) {
    loggerNoStack.v(widget.course);
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
            Wrap(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 16,
                  color: Color.fromRGBO(139, 147, 151, 1),
                ),
                Text(
                  widget.course["location"]!,
                  style: const TextStyle(
                    color: Color.fromRGBO(139, 147, 151, 1),
                  ),
                ),
              ],
            ),
            Wrap(
              children: [
                const Icon(
                  Icons.show_chart,
                  size: 18,
                  color: Color.fromRGBO(53, 69, 84, 1),
                ),
                const SizedBox(
                  width: 2,
                ),
                Text(
                  widget.course["level"]![0].toUpperCase() +
                      widget.course["level"]!.substring(1),
                  style: const TextStyle(
                      color: Color.fromRGBO(53, 69, 84, 1), fontSize: 16),
                ),
              ],
            ),
            Wrap(
              children: [
                const Icon(
                  Icons.groups,
                  size: 18,
                  color: Color.fromRGBO(53, 69, 84, 1),
                ),
                const SizedBox(
                  width: 2,
                ),
                Text(
                  widget.course["target_group"]![0].toUpperCase() +
                      widget.course["target_group"]!.substring(1),
                  style: const TextStyle(
                      color: Color.fromRGBO(53, 69, 84, 1), fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
