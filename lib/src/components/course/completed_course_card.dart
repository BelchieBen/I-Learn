import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'course_tags.dart';
import 'learning_types.dart';

class CompletedCourseCard extends StatelessWidget {
  final Map<String, dynamic> course;
  const CompletedCourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Image.asset(
                  course["sessions"]["courses"]["image"]!,
                  height: 110,
                  width: 110,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course["sessions"]["courses"]["title"]!,
                      style: const TextStyle(fontSize: 18),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          size: 16,
                          color: Color.fromRGBO(8, 167, 104, 1),
                        ),
                        Text(
                          course["sessions"]["start_date"]!,
                          style: const TextStyle(
                            color: Color.fromRGBO(110, 120, 129, 1),
                          ),
                        ),
                      ],
                    ),
                    LearningTypes(
                      contentTypes: course["sessions"]["courses"]
                          ["course_learning_types"]!,
                    ),
                    CourseTags(
                        tags: course["sessions"]["courses"]["course_tags"]!,
                        tagSize: 11),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 30,
              width: 140,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Simular Courses"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
