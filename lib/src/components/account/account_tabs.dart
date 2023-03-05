import 'package:booking_app/src/components/course/completed_course_card.dart';
import 'package:booking_app/src/components/course/learning_pathway_card.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AccountTabs extends StatefulWidget {
  final List<Map<String, String>> currentPathwayProgression;
  final Map<String, dynamic> userInfo;

  const AccountTabs({
    super.key,
    required this.currentPathwayProgression,
    required this.userInfo,
  });

  State<AccountTabs> createState() => _AccountTabsState();
}

class _AccountTabsState extends State<AccountTabs> {
  List coursesCompleted = [];
  String tab = "learning_record";
  int maxCompletedCoursItems = 2;
  int maxLearningPathways = 2;

  bool completedCoursesLoading = false;

  @override
  void initState() {
    super.initState();
    SupabaseClient supabase = Supabase.instance.client;
    _fetchCompletedCourses(supabase);
  }

  void _fetchCompletedCourses(SupabaseClient supabase) async {
    setState(() => completedCoursesLoading = true);
    var currentUserId = supabase.auth.currentUser?.id;
    if (currentUserId != null || currentUserId != "") {
      final coursesCompletedResponse = await supabase
          .from("user_bookings")
          .select(
              "*, sessions(*,courses(*,course_tags(id,tags(tag)), course_learning_types(id, learning_types(learning_type))))")
          .filter("employee", "eq", currentUserId)
          .filter('status', 'eq', 'complete');

      setState(() {
        coursesCompleted = coursesCompletedResponse;
        completedCoursesLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String? email = Supabase.instance.client.auth.currentUser?.email;
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
                            maxCompletedCoursItems = coursesCompleted.length;
                          });
                        }
                      },
                      child: coursesCompleted.isEmpty ||
                              coursesCompleted.length < 3
                          ? SizedBox.shrink()
                          : Text(maxCompletedCoursItems == 2
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
                        subtitle: Text(widget.userInfo["user_id"]!),
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.person_outline,
                          color: Colors.black,
                        ),
                        title: const Text("Name"),
                        subtitle: Text(widget.userInfo["full_name"]!),
                      ),
                      email != null
                          ? ListTile(
                              leading: const Icon(
                                Icons.alternate_email,
                                color: Colors.black,
                              ),
                              title: const Text("Email"),
                              subtitle: Text(email),
                            )
                          : const SizedBox.shrink(),
                      ListTile(
                        leading: const Icon(
                          Icons.phone,
                          color: Colors.black,
                        ),
                        title: const Text("Phone Number"),
                        subtitle: Text(widget.userInfo["phone"]!),
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
        completedCoursesLoading
            ? const SizedBox(
                height: 150,
                child: Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 2,
                )),
              )
            : SizedBox(
                width: double.infinity,
                child: coursesCompleted.isEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          Image.asset("images/empty.png", width: 300),
                          const Text("No Items", style: TextStyle(fontSize: 18))
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
        for (int courseIndex = 0;
            courseIndex < coursesCompleted.length;
            courseIndex++)
          courseIndex < maxCompletedCoursItems
              ? CompletedCourseCard(course: coursesCompleted[courseIndex])
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
