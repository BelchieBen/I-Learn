import 'package:flutter/material.dart';

class CourseDetailPage extends StatefulWidget {
  final Map<String, String> course;
  const CourseDetailPage({super.key, required this.course});

  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
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
            child: Column(
              children: [
                Text(widget.course["title"]!),
              ],
            ),
          ),
        );
      }),
    );
  }
}
