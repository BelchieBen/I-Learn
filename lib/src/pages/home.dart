import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:booking_app/src/pages/courses/course_detail.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List recomendedCourses = [];
  List upcomingItems = [];
  @override
  void initState() {
    super.initState();
    final supabase = Supabase.instance.client;
    _fetchRecomendedCourses(supabase);
    _fetchUpcomingCourses(supabase);
  }

  // Method to fetch 4 courses to be displayed in the recomended courses section
  // The method sends a query to the Supabase db courses table, orders results and limits them to 4
  void _fetchRecomendedCourses(SupabaseClient supabase) async {
    final courses = await supabase
        .from("courses")
        .select(
            "*,course_tags(id,tags(tag)), course_learning_types(id, learning_types(learning_type))")
        .order("created_at")
        .limit(4);
    setState(() {
      recomendedCourses = courses.toList();
    });
  }

  // Method to fetch any Sessions the user has booked from Supabase db, I exclude Sessions that
  // are marked as completed or cancelled as they are not required for this UI section.
  void _fetchUpcomingCourses(SupabaseClient supabase) async {
    final upcomingCourses = await supabase
        .from("user_bookings")
        .select(
            "*, sessions(*,courses(*,course_tags(id,tags(tag)), course_learning_types(id, learning_types(learning_type))))")
        .neq("status", "complete")
        .neq("status", "Cancelled");
    setState(() {
      upcomingItems = upcomingCourses.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        // I have used a SingleChildScrollView to make the entire page scrollable
        // which keeps the UI responsive
        return SingleChildScrollView(
            child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Recomended for you"),
                const Divider(),
                Align(
                  alignment: Alignment.center,
                  // Checking to see if we have any courses to display, if not show a loading indicator
                  child: recomendedCourses.isEmpty
                      ? Column(children: const [
                          SizedBox(
                            height: 50,
                          ),
                          CircularProgressIndicator(
                            color: Color.fromRGBO(5, 109, 120, 1),
                            strokeWidth: 2,
                          ),
                          SizedBox(
                            height: 50,
                          ),
                        ])
                      : Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          children: [
                            // I chose to use a range based for loop for better readability
                            // when accessing the array items properties
                            for (var item in recomendedCourses)
                              FractionallySizedBox(
                                widthFactor: 0.49,
                                child: Card(
                                  color: Colors.white,
                                  clipBehavior: Clip.none,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CourseDetailPage(
                                            course: item,
                                            showBookBtn: true,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 12),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            item["image"]!,
                                            width: 140,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(item["title"]!),
                                              Text(
                                                item["course_tags"][0]["tags"]
                                                    ["tag"]!,
                                                style: const TextStyle(
                                                    fontSize: 10),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            const SizedBox(
                              height: 12,
                            ),
                            const Text("Your upcoming courses"),
                            const Divider(),
                            // More validation to check if the courses list is empty
                            // and display a loading indicator if we have no items
                            upcomingItems.isEmpty
                                ? SizedBox(
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          height: 50,
                                        ),
                                        Image.asset("images/empty.png",
                                            width: 250),
                                        const Text("No Items",
                                            style: TextStyle(fontSize: 18))
                                      ],
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            // I chose to use a range based for loop for better readability
                            // when accessing the array items properties
                            for (var item in upcomingItems)
                              ListTile(
                                leading: Image.asset(
                                  item["sessions"]["courses"]["image"]!,
                                  width: 60,
                                ),
                                title:
                                    Text(item["sessions"]["courses"]["title"]!),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item["sessions"]["start_date"]! +
                                          " " +
                                          item["sessions"]["start_time"]!
                                              .substring(0, 5) +
                                          " - " +
                                          item["sessions"]["end_date"]! +
                                          " " +
                                          item["sessions"]["end_time"]!
                                              .substring(0, 5),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          size: 18,
                                          color:
                                              Color.fromRGBO(139, 147, 151, 1),
                                        ),
                                        Text(
                                          item["sessions"]["courses"]
                                              ["location"]!,
                                          style: const TextStyle(
                                            color: Color.fromRGBO(
                                                139, 147, 151, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          // CourseDetail(course: item),
                                          CourseDetailPage(
                                        course: item["sessions"]["courses"],
                                        showBookBtn: false,
                                      ),
                                    ),
                                  );
                                },
                              ),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ));
      },
    );
  }
}
