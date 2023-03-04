import 'package:flutter/material.dart';

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
