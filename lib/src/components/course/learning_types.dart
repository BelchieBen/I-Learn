import 'package:flutter/material.dart';

class LearningTypes extends StatefulWidget {
  final List<String> contentTypes;
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
          for (var type in widget.contentTypes)
            Image.asset(
              "images/contentImages/$type",
              height: 25,
            ),
        ],
      ),
    );
  }
}
