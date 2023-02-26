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
  int maxCompletedCoursItems = 2;
  int maxLearningPathways = 2;
  String tab = "learning_record";
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
      "pathwayStep": "3",
      "steps": "Intermediate,Advanced,Expert",
    },
  ];

  static const userInfo = {
    "employeeId": "123456",
    "name": "Ben Belcher",
    "email": "benjamin.belcher@ideagen.com",
    "phoneNumber": "09765434567",
    "dob": "01/01/2000",
  };

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
              minWidth: viewportConstraints.maxWidth,
              maxWidth: viewportConstraints.maxWidth),
          child: Theme(
            data: ThemeData(
              colorScheme: Theme.of(context).colorScheme.copyWith(
                    primary: const Color.fromRGBO(27, 131, 139, 1),
                  ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                accountProfile(),
                tabButtons(context),
                (tab == "learning_record")
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            coursesCompletedSection(),
                            TextButton(
                              onPressed: () {
                                if (maxCompletedCoursItems != 2) {
                                  setState(() {
                                    maxCompletedCoursItems = 2;
                                  });
                                } else {
                                  setState(() {
                                    maxCompletedCoursItems =
                                        coursesCompleted.length;
                                  });
                                }
                              },
                              child: Text(maxCompletedCoursItems == 2
                                  ? "Show All"
                                  : "Show Less"),
                            ),
                            learnigPathwaysSection(),
                            TextButton(
                              onPressed: () {
                                if (maxLearningPathways != 2) {
                                  setState(() {
                                    maxLearningPathways = 2;
                                  });
                                } else {
                                  setState(() {
                                    maxLearningPathways =
                                        currentPathwayProgression.length;
                                  });
                                }
                              },
                              child: Text(maxLearningPathways == 2
                                  ? "Show All"
                                  : "Show Less"),
                            ),
                          ],
                        ),
                      )
                    : (tab == "personal_details")
                        ? Column(
                            children: [
                              ListTile(
                                leading: const Icon(
                                  Icons.credit_card,
                                  color: Colors.black,
                                ),
                                title: const Text("Employee ID"),
                                subtitle: Text(userInfo["employeeId"]!),
                              ),
                              ListTile(
                                leading: const Icon(
                                  Icons.person_outline,
                                  color: Colors.black,
                                ),
                                title: const Text("Name"),
                                subtitle: Text(userInfo["name"]!),
                              ),
                              ListTile(
                                leading: const Icon(
                                  Icons.alternate_email,
                                  color: Colors.black,
                                ),
                                title: const Text("Email"),
                                subtitle: Text(userInfo["email"]!),
                              ),
                              ListTile(
                                leading: const Icon(
                                  Icons.phone,
                                  color: Colors.black,
                                ),
                                title: const Text("Phone Number"),
                                subtitle: Text(userInfo["phoneNumber"]!),
                              ),
                              ListTile(
                                leading: const Icon(
                                  Icons.perm_contact_calendar,
                                  color: Colors.black,
                                ),
                                title: const Text("Date of Birth"),
                                subtitle: Text(userInfo["dob"]!),
                              ),
                            ],
                          )
                        : const SizedBox.shrink()
              ],
            ),
          ),
        ),
      );
    });
  }

  Wrap tabButtons(BuildContext context) {
    return Wrap(
      children: [
        Container(
          decoration: tab == "learning_record"
              ? const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 2,
                      color: Color.fromRGBO(5, 109, 120, 1),
                    ),
                  ),
                )
              : null,
          width: (MediaQuery.of(context).size.width / 2),
          child: TextButton(
            onPressed: () {
              setState(() {
                tab = "learning_record";
              });
            },
            child: const Text(
              "Learning Record",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        Container(
          decoration: tab == "personal_details"
              ? const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 2,
                      color: Color.fromRGBO(5, 109, 120, 1),
                    ),
                  ),
                )
              : null,
          width: (MediaQuery.of(context).size.width / 2),
          child: TextButton(
            onPressed: () {
              setState(() {
                tab = "personal_details";
              });
            },
            child: const Text(
              "Personal Details",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
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

  Column coursesCompletedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Courses Completed"),
        const Divider(),
        for (int courseIndex = 0;
            courseIndex < coursesCompleted.length;
            courseIndex++)
          courseIndex < maxCompletedCoursItems
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
            courseIndex < currentPathwayProgression.length;
            courseIndex++)
          courseIndex < maxLearningPathways
              ? learningPathwayCard(currentPathwayProgression[courseIndex])
              : const SizedBox.shrink(),
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
