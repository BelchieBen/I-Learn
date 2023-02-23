import 'package:flutter/material.dart';

class SearchCourses extends StatefulWidget {
  const SearchCourses({super.key});

  @override
  State<SearchCourses> createState() => _SearchCoursesState();
}

class _SearchCoursesState extends State<SearchCourses> {
  final courses = [
    {
      "title": "Courageous Conversations",
      "image": "images/CompanyNews.png",
      "learningContents": "FaceToFace.png,Podcast.png,TopTips.png,Article.png",
      "tags": "Duration: 2 Hours,Maximum Attendees: 12,Suitable for everyone",
    }
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
                        child: Row(
                          children: [
                            Image.asset(
                              course["image"]!,
                              height: 120,
                            ),
                            Column(
                              children: [
                                Text(course["title"]!),
                                // TODO add the tags and learning content
                              ],
                            )
                          ],
                        ),
                      )
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
