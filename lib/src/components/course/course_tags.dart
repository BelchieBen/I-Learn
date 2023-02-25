import 'package:flutter/material.dart';

class CourseTags extends StatefulWidget {
  final List<String> tags;
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
          for (var tag in widget.tags)
            Wrap(
              children: [
                Text(
                  tag,
                  style: TextStyle(
                    color: const Color.fromRGBO(200, 0, 99, 1),
                    fontSize: widget.tagSize,
                  ),
                ),
                tag != widget.tags.last
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
