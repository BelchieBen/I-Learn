import 'package:flutter/material.dart';

// Component to render the learning types for each course in a list like form.
// These appear on most course/ booking cards throughout the app
// @param contentTypes is a List of objects from the database that contain a reference to an image stored in the app bundle
class LearningTypes extends StatefulWidget {
  final List contentTypes;
  const LearningTypes({super.key, required this.contentTypes});

  State<LearningTypes> createState() => _LearningTypesState();
}

class _LearningTypesState extends State<LearningTypes> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: Wrap(
        spacing: 8,
        children: [
          for (Map<String, dynamic> type in widget.contentTypes)
            Image.asset(
              "images/contentImages/${type["learning_types"]["learning_type"]}",
              height: 25,
            ),
        ],
      ),
    );
  }
}
