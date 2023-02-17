import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final recomendedItems = [
    {
      "title": "Time Management",
      "image": "images/FastEasyReporting.png",
      "altText": "16 Lessons",
    },
    {
      "title": "Risk Management",
      "image": "images/ReportingExecutiveDashboards.png",
      "altText": "8 Lessons",
    },
    {
      "title": "Effective Planning",
      "image": "images/RiskAssessmentDocumentation.png",
      "altText": "2 Days In Person",
    },
    {
      "title": "Meeting Prep",
      "image": "images/CalendersReminders.png",
      "altText": "1 Day In Person",
    },
  ];

  final upcomingItems = [
    {
      "title": "COSHH Training",
      "image": "images/COSHH.png",
      "altText": "Supporting line text lorem ipsum dolor sit amet, consectetur",
    },
    {
      "title": "Health & Safety",
      "image": "images/FirstAid.png",
      "altText": "Supporting line text lorem ipsum dolor sit amet, consectetur",
    },
    {
      "title": "Food Heigine",
      "image": "images/FoodSafetyLevel.png",
      "altText": "Supporting line text lorem ipsum dolor sit amet, consectetur",
    },
    {
      "title": "Asbestos Awareness",
      "image": "images/AsbestosAwareness.png",
      "altText":
          "Supporting line text lorem ipsum dolor sit amet, consectetur Will you show up?",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Recomended for you"),
                  const Divider(),
                  Align(
                    alignment: Alignment.center,
                    child: Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      children: [
                        for (var item in recomendedItems)
                          FractionallySizedBox(
                            widthFactor: 0.49,
                            child: Card(
                              clipBehavior: Clip.none,
                              child: InkWell(
                                splashColor:
                                    const Color.fromRGBO(92, 199, 208, 0.2),
                                onTap: () {
                                  print('Card tapped.');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        item["image"]!,
                                        width: 120,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(item["title"]!),
                                          Text(
                                            item["altText"]!,
                                            style:
                                                const TextStyle(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text("Your upcoming courses"),
                  const Divider(),
                  for (var item in upcomingItems)
                    ListTile(
                      leading: Image.asset(
                        item["image"]!,
                        width: 60,
                      ),
                      title: Text(item["title"]!),
                      subtitle: Text(
                        item["altText"]!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      isThreeLine: true,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
