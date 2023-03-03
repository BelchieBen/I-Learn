import 'package:flutter/material.dart';

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
