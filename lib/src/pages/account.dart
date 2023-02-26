import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../components/account/account_tabs.dart';
import '../components/course/course_tags.dart';
import '../components/course/learning_types.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  int maxItems = 2;
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

  static const currentPathwayProgression = [
    {
      "title": "COSHH Training",
      "image": "images/COSHH.png",
      "pathwayStep": "1",
      "steps": "Basics,Intermediate,Expert",
    },
    {
      "title": "Coaching",
      "image": "images/BackToWork.png",
      "pathwayStep": "2",
      "steps": "Basics,Intermediate,Expert",
    },
    {
      "title": "Computer Safety",
      "image": "images/CentralisedSafety Data.png",
      "pathwayStep": "0",
      "steps": "Intermediate,Advanced,Expert",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: const Color.fromRGBO(27, 131, 139, 1),
            ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      child: ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                accountProfile(),
                DefaultTabController(
                  initialIndex: 0,
                  length: 2,
                  child: Column(
                    children: [
                      accountTabBar(),
                      accountTabsContent(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container accountProfile() {
    return Container(
      height: 250,
      color: const Color.fromRGBO(228, 252, 255, 1),
      child: Column(children: [
        const Spacer(),
        const Text(
          "Ben Belcher",
          style: TextStyle(fontSize: 24),
        ),
        const Text(
          "Technology Solutions Apprentice",
          style: TextStyle(
            color: Color.fromRGBO(93, 105, 119, 1),
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SvgPicture.asset("images/books.svg"),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "https://cdn.pixabay.com/photo/2016/11/29/03/15/man-1867009_960_720.jpg"),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              SvgPicture.asset("images/booksRight.svg"),
            ],
          ),
        )
      ]),
    );
  }

  Container accountTabsContent(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: TabBarView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                coursesCompletedSection(),
                TextButton(
                  onPressed: () {
                    if (maxItems != 2) {
                      setState(() {
                        maxItems = 2;
                      });
                    } else {
                      setState(() {
                        maxItems = coursesCompleted.length;
                      });
                    }
                  },
                  child: Text(maxItems == 2 ? "Show All" : "Show Less"),
                ),
                learnigPathwaysSection()
              ],
            ),
          ),
          const Center(
            child: Text("It's rainy here"),
          ),
        ],
      ),
    );
  }

  Column coursesCompletedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Courses Completed"),
        const Divider(),
        for (int courseIndex = 0;
            courseIndex < coursesCompleted.length;
            courseIndex++)
          courseIndex < maxItems
              ? completedCourseCard(coursesCompleted[courseIndex])
              : const SizedBox.shrink(),
      ],
    );
  }

  Column learnigPathwaysSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Learnig Pathways"),
        const Divider(),
        for (int courseIndex = 0;
            courseIndex < coursesCompleted.length;
            courseIndex++)
          courseIndex < maxItems
              ? learningPathwayCard(currentPathwayProgression[courseIndex])
              : const SizedBox.shrink(),
      ],
    );
  }

  TabBar accountTabBar() {
    return const TabBar(
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
    );
  }

  Card completedCourseCard(Map<String, String> course) {
    return Card(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          color: Color.fromRGBO(8, 167, 104, 1),
                        ),
                        Text(
                          course["date"]!,
                          style: const TextStyle(
                            color: Color.fromRGBO(110, 120, 129, 1),
                          ),
                        ),
                      ],
                    ),
                    LearningTypes(
                      contentTypes:
                          course["learningTypes"]!.split(",").toList(),
                    ),
                    CourseTags(
                        tags: course["tags"]!.split(",").toList(), tagSize: 11),
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
    );
  }

  Card learningPathwayCard(Map<String, String> course) {
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

  StepProgressIndicator learningPathwayProgression(Map<String, String> course) {
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
