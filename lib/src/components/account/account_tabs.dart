import 'package:booking_app/src/components/course/completed_course_card.dart';
import 'package:booking_app/src/components/course/learning_pathway_card.dart';
import 'package:flutter/material.dart';

class AccountTabs extends StatefulWidget {
  final List<Map<String, String>> coursesCompleted;
  final List<Map<String, String>> currentPathwayProgression;
  final Map<String, String> userInfo;

  const AccountTabs({
    super.key,
    required this.coursesCompleted,
    required this.currentPathwayProgression,
    required this.userInfo,
  });

  State<AccountTabs> createState() => _AccountTabsState();
}

class _AccountTabsState extends State<AccountTabs> {
  String tab = "learning_record";
  int maxCompletedCoursItems = 2;
  int maxLearningPathways = 2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
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
        ),
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
                                widget.coursesCompleted.length;
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
                                widget.currentPathwayProgression.length;
                          });
                        }
                      },
                      child: Text(
                          maxLearningPathways == 2 ? "Show All" : "Show Less"),
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
                        subtitle: Text(widget.userInfo["employeeId"]!),
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.person_outline,
                          color: Colors.black,
                        ),
                        title: const Text("Name"),
                        subtitle: Text(widget.userInfo["name"]!),
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.alternate_email,
                          color: Colors.black,
                        ),
                        title: const Text("Email"),
                        subtitle: Text(widget.userInfo["email"]!),
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.phone,
                          color: Colors.black,
                        ),
                        title: const Text("Phone Number"),
                        subtitle: Text(widget.userInfo["phoneNumber"]!),
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.perm_contact_calendar,
                          color: Colors.black,
                        ),
                        title: const Text("Date of Birth"),
                        subtitle: Text(widget.userInfo["dob"]!),
                      ),
                    ],
                  )
                : const SizedBox.shrink()
      ],
    );
  }

  Column coursesCompletedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Courses Completed"),
        const Divider(),
        for (int courseIndex = 0;
            courseIndex < widget.coursesCompleted.length;
            courseIndex++)
          courseIndex < maxCompletedCoursItems
              ? CompletedCourseCard(
                  course: widget.coursesCompleted[courseIndex])
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
            courseIndex < widget.currentPathwayProgression.length;
            courseIndex++)
          courseIndex < maxLearningPathways
              ? LearningPathwayCard(
                  course: widget.currentPathwayProgression[courseIndex])
              : const SizedBox.shrink(),
      ],
    );
  }
}
