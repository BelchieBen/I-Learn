import 'package:booking_app/src/components/course/course_tags.dart';
import 'package:booking_app/src/components/course/learning_types.dart';
import 'package:flutter/material.dart';

class AccountTabs extends StatelessWidget {
  const AccountTabs({super.key});

  static const coursesCompleted = [
    {
      "title": "Courageous Conversations",
      "image": "images/CompanyNews.png",
      "date": "20/04/2022 9:00",
      "tags": "Face to Face 1 Day,Suitable for everyone",
      "learningTypes": "FaceToFace.png,Podcast.png,TopTips.png,Article.png",
    },
    {
      "title": "Coaching",
      "image": "images/BackToWork.png",
      "date": "13/05/2022 9:00",
      "tags": "Face to Face 2 Days,Suitable for everyone",
      "learningTypes": "FaceToFace.png,Podcast.png,TopTips.png,Article.png",
    },
    {
      "title": "Computer Safety",
      "image": "images/CentralisedSafety Data.png",
      "date": "25/01/2023 9:00",
      "tags": "Face to Face 1 Day,Suitable for everyone",
      "learningTypes": "FaceToFace.png,Podcast.png,TopTips.png,Article.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Column(
        children: [
          const TabBar(
            labelColor: Colors.black,
            indicatorColor: Color.fromRGBO(92, 199, 208, 1),
            tabs: <Widget>[
              Tab(
                text: "Learning Record",
              ),
              Tab(
                text: "Personal Details",
              ),
            ],
          ),
          SizedBox(
            height: 378,
            child: TabBarView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Courses Completed"),
                      const Divider(),
                      for (var course in coursesCompleted)
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      course["image"]!,
                                      height: 110,
                                      width: 110,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          course["title"]!,
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.check_circle_outline,
                                              size: 16,
                                              color: Color.fromRGBO(
                                                  8, 167, 104, 1),
                                            ),
                                            Text(
                                              course["date"]!,
                                              style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    110, 120, 129, 1),
                                              ),
                                            ),
                                          ],
                                        ),
                                        LearningTypes(
                                          contentTypes: course["learningTypes"]!
                                              .split(",")
                                              .toList(),
                                        ),
                                        CourseTags(
                                            tags: course["tags"]!
                                                .split(",")
                                                .toList(),
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
                        )
                    ],
                  ),
                ),
                const Center(
                  child: Text("It's rainy here"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
