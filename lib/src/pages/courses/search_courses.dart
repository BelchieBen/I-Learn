import 'package:booking_app/src/components/course/course_tags.dart';
import 'package:booking_app/src/components/course/learning_types.dart';
import 'package:flutter/material.dart';

class SearchCourses extends StatefulWidget {
  const SearchCourses({super.key});

  @override
  State<SearchCourses> createState() => _SearchCoursesState();
}

class _SearchCoursesState extends State<SearchCourses> {
  final courses = [
    {
      "title": "Difficult Conversations",
      "image": "images/CompanyNews.png",
      "learningContents": "FaceToFace.png,Podcast.png,TopTips.png,Article.png",
      "tags": "Duration: 2 Hours,Suitable for everyone",
    },
    {
      "title": "Coaching",
      "image": "images/BackToWork.png",
      "learningContents": "FaceToFace.png,Video.png,Article.png",
      "tags": "Duration: 2 Hours,Suitable for everyone",
    },
    {
      "title": "Computer Safety",
      "image": "images/CentralisedSafety Data.png",
      "learningContents": "FaceToFace.png,Podcast.png,TopTips.png,Article.png",
      "tags": "Duration: 2 Hours,Suitable for everyone",
    },
    {
      "title": "Team Collaboration",
      "image": "images/Collaboration.png",
      "learningContents": "EBook.png,ELearning.png,TopTips.png,Online.png",
      "tags": "Duration: 2 Hours,Suitable for everyone",
    },
    {
      "title": "First Aid Training",
      "image": "images/FirstAid.png",
      "learningContents": "Video.png,Podcast.png,TopTips.png",
      "tags": "Duration: 2 Hours,Suitable for everyone",
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
              child: Theme(
                data: ThemeData(
                  canvasColor: Colors.transparent,
                  colorScheme: Theme.of(context).colorScheme.copyWith(
                        primary: const Color.fromRGBO(93, 105, 119, 1),
                      ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    filterButtons(),
                    const Text("Popular Courses"),
                    const Divider(),
                    for (var course in courses)
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Image.asset(
                                course["image"]!,
                                width: 90,
                                height: 90,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    course["title"]!,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  LearningTypes(
                                    contentTypes:
                                        course["learningContents"]!.split(","),
                                  ),
                                  CourseTags(
                                    tags: course["tags"]!.split(","),
                                    tagSize: 11,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Courses for you division"),
                    const Divider(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Row filterButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.sort),
          label: const Text("Sort"),
        ),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.filter_list),
          label: const Text("Filter"),
        ),
      ],
    );
  }
}
