import 'package:flutter/material.dart';

// Reusable component to render the tags associated with a course
// @param tags, a List of tags from the database. Each tag is a string
// @param tagSize, a number which sets the font size of erach tag, useful to fit the tags into varying spaces in the UI
class CourseTags extends StatefulWidget {
  final List tags;
  final double tagSize;
  const CourseTags({super.key, required this.tags, required this.tagSize});

  State<CourseTags> createState() => _CourseTageState();
}

class _CourseTageState extends State<CourseTags> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
      child: Wrap(
        children: [
          for (Map<String, dynamic> tagObj in widget.tags)
            Wrap(
              children: [
                Text(
                  tagObj["tags"]["tag"],
                  style: TextStyle(
                    color: const Color.fromRGBO(200, 0, 99, 1),
                    fontSize: widget.tagSize,
                  ),
                ),
                tagObj != widget.tags.last
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Text(
                          "|",
                          style: TextStyle(
                              color: const Color.fromRGBO(200, 0, 99, 1),
                              fontSize: widget.tagSize),
                        ),
                      )
                    : const Text(""),
              ],
            ),
        ],
      ),
    );
  }
}
