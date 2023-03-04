import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class LearningPathwayCard extends StatelessWidget {
  final Map<String, dynamic> course;
  const LearningPathwayCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course["title"]!,
                  style: const TextStyle(fontSize: 18),
                ),
                const Divider(),
                Row(
                  children: [
                    Image.asset(
                      course["image"]!,
                      height: 110,
                      width: 110,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          learningPathwayProgression(course),
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
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  StepProgressIndicator learningPathwayProgression(
      Map<String, dynamic> course) {
    return StepProgressIndicator(
      totalSteps: course["steps"]!.split(",").toList().length,
      currentStep: int.parse(course["pathwayStep"]!),
      size: 36,
      selectedColor: const Color.fromRGBO(8, 167, 104, 1),
      unselectedColor: const Color.fromRGBO(158, 166, 173, 1),
      customStep: (index, color, _) =>
          index >= int.parse(course["pathwayStep"]!)
              ? Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color,
                      ),
                      child: Center(
                        child: Text(
                          (index + 1).toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      course["steps"]!.split(",").toList()[index],
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                )
              : Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    Text(
                      course["steps"]!.split(",").toList()[index],
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                ),
    );
  }
}
