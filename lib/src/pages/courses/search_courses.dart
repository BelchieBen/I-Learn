import 'package:booking_app/src/components/course/course_tags.dart';
import 'package:booking_app/src/components/course/learning_types.dart';
import 'package:flutter/material.dart';

class SearchCourses extends StatefulWidget {
  const SearchCourses({super.key});

  @override
  State<SearchCourses> createState() => _SearchCoursesState();
}

class _SearchCoursesState extends State<SearchCourses> {
  int _selectedSortIndex = 0;
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
    {
      "title": "Assertive Communication",
      "image": "images/ConflictResolution.png",
      "learningContents": "FaceToFace.png,Podcast.png,TopTips.png,Article.png",
      "tags": "Duration: 4 Hours,Suitable for everyone",
    },
    {
      "title": "Assertive Communication",
      "image": "images/ConflictResolution.png",
      "learningContents": "FaceToFace.png,Podcast.png,TopTips.png,Article.png",
      "tags": "Duration: 4 Hours,Suitable for everyone",
    },
  ];

  final sortFilters = [
    {"icon": Icons.keyboard_double_arrow_up, "sortBy": "Relevence"},
    {"icon": Icons.arrow_downward, "sortBy": "Name Descending"},
    {"icon": Icons.arrow_upward, "sortBy": "Name Ascending"},
    {"icon": Icons.notification_add_outlined, "sortBy": "Recently Added"},
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                    child: filterButtons(),
                  ),
                  coursesListView(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  ListView coursesListView() {
    return ListView.builder(
      itemCount: courses.length,
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, index) {
        final course = courses[index];
        return Card(
          color: const Color.fromARGB(255, 250, 249, 252),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: () {},
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
                        contentTypes: course["learningContents"]!.split(","),
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
        );
      },
    );
  }

  void _settingModalBottomSheet(context) {
    showBottomSheet(
        context: context,
        elevation: 2,
        enableDrag: true,
        builder: (BuildContext bc) {
          return Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Row(
                children: const [
                  Spacer(),
                  SizedBox(
                    width: 100,
                    height: 2,
                    child: Divider(
                      thickness: 2,
                    ),
                  ),
                  Spacer(),
                ],
              ),
              for (var sort in sortFilters)
                ListTile(
                    leading: Icon(sort["icon"]! as IconData?),
                    selected: _selectedSortIndex == sortFilters.indexOf(sort),
                    title: Text(sort["sortBy"]! as String),
                    onTap: () => {
                          Navigator.of(context).pop(),
                          setState(() {
                            _selectedSortIndex = sortFilters.indexOf(sort);
                          })
                        }),
            ],
          );
        });
  }

  Builder filterButtons() {
    final int courseCount = courses.length;
    return Builder(builder: (context) {
      return Row(
        children: [
          Text("Showing $courseCount courses"),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () {
                  _settingModalBottomSheet(context);
                },
                icon: const Icon(Icons.sort),
                label: const Text("Sort"),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.filter_list),
                label: const Text("Filter"),
              ),
            ],
          ),
        ],
      );
    });
  }
}
