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

  void _fetchRecomendedCourses(SupabaseClient supabase) async {
    final courses = await supabase
        .from("courses")
        .select(
            "*,course_tags(id,tags(tag)), course_learning_types(id, learning_types(learning_type))")
        .limit(4);
    setState(() {
      recomendedCourses = courses.toList();
    });
  }

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
                                              // CourseDetail(course: item),
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
                                        course: item,
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
