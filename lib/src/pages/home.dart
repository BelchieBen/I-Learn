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
  @override
  void initState() {
    super.initState();
    final supabase = Supabase.instance.client;
    _fetchRecomendedCourses(supabase);
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
    final courses = await supabase
        .from("user_bookings")
        .select("*,users(*), sessions(*, courses(*), users(*))")
        .limit(4);
    setState(() {
      recomendedCourses = courses.toList();
    });
  }

  final upcomingItems = [
    {
      "title": "COSHH Training",
      "image": "images/COSHH.png",
      "location": "Ruddington",
      "altText": "30-03-2022 9:00 - 30-03-2022 17:00",
      "description":
          "Time management enables each of us to improve and be more productive and fulfilled individually, so logically the effects across whole organisations of good or poor time management are enormous. In fact, a 2007 survey of 2500 businesses over a four-year period indicated that on average wasted time cost UK businesses £80bn per year! Save time and money by learning how to properly plan and protect your time!",
      "quoteText":
          "I apply most of the techniques I learnt in training in both my personal and professional life",
      "tags": "Duration: 2 Hours,Maximum Attendees: 12,Suitable for everyone",
      "learningContents": "FaceToFace.png,Podcast.png,TopTips.png,Article.png",
    },
    {
      "title": "Health & Safety",
      "image": "images/FirstAid.png",
      "location": "MS Teams",
      "altText": "20-03-2022 9:00 - 23-03-2022 17:00",
      "description":
          "Time management enables each of us to improve and be more productive and fulfilled individually, so logically the effects across whole organisations of good or poor time management are enormous. In fact, a 2007 survey of 2500 businesses over a four-year period indicated that on average wasted time cost UK businesses £80bn per year! Save time and money by learning how to properly plan and protect your time!",
      "quoteText":
          "I apply most of the techniques I learnt in training in both my personal and professional life",
      "tags": "Duration: 2 Hours,Maximum Attendees: 12,Suitable for everyone",
      "learningContents": "FaceToFace.png,Podcast.png,TopTips.png,Article.png",
    },
    {
      "title": "Food Heigine",
      "image": "images/FoodSafetyLevel.png",
      "location": "Ruddington",
      "altText": "09-03-2022 9:00 - 09-03-2022 11:00",
      "description":
          "Time management enables each of us to improve and be more productive and fulfilled individually, so logically the effects across whole organisations of good or poor time management are enormous. In fact, a 2007 survey of 2500 businesses over a four-year period indicated that on average wasted time cost UK businesses £80bn per year! Save time and money by learning how to properly plan and protect your time!",
      "quoteText":
          "I apply most of the techniques I learnt in training in both my personal and professional life",
      "tags": "Duration: 2 Hours,Maximum Attendees: 12,Suitable for everyone",
      "learningContents": "FaceToFace.png,Podcast.png,TopTips.png,Article.png",
    },
    {
      "title": "Asbestos Awareness",
      "image": "images/AsbestosAwareness.png",
      "location": "Pre-Recorded Sessions",
      "altText": "24-03-2022 9:00 - 25-03-2022 17:00",
      "description":
          "Time management enables each of us to improve and be more productive and fulfilled individually, so logically the effects across whole organisations of good or poor time management are enormous. In fact, a 2007 survey of 2500 businesses over a four-year period indicated that on average wasted time cost UK businesses £80bn per year! Save time and money by learning how to properly plan and protect your time!",
      "quoteText":
          "I apply most of the techniques I learnt in training in both my personal and professional life",
      "tags": "Duration: 2 Hours,Maximum Attendees: 12,Suitable for everyone",
      "learningContents": "FaceToFace.png,Podcast.png,TopTips.png,Article.png",
    },
  ];

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
                                              CourseDetailPage(course: item),
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
                            for (var item in upcomingItems)
                              ListTile(
                                leading: Image.asset(
                                  item["image"]!,
                                  width: 60,
                                ),
                                title: Text(item["title"]!),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item["altText"]!),
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
                                          item["location"]!,
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
                                          CourseDetailPage(course: item),
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
