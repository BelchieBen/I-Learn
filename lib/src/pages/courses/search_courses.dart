import 'package:booking_app/providers/search_term.dart';
import 'package:booking_app/providers/searching.dart';
import 'package:booking_app/src/components/course/course_tags.dart';
import 'package:booking_app/src/components/course/learning_types.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/course/course_filter.dart';

class SearchCourses extends StatefulWidget {
  const SearchCourses({super.key});

  @override
  State<SearchCourses> createState() => _SearchCoursesState();
}

class _SearchCoursesState extends State<SearchCourses> {
  int _selectedSortIndex = 0;
  bool showFilters = false;

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

  final List<String> courseType = [
    'In Person',
    'Online MS Teams',
    'Pre-Recorded',
  ];

  final List<String> courseCategory = [
    'Technical',
    'Collaboration',
    'Self Improvement',
    'Leadership',
    'Health & Safety',
  ];

  final List<String> level = [
    'Entry Level',
    'Advanced',
    'Expert',
  ];

  final List<String> mandatory = [
    'Mandatory',
    'Optional',
  ];

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
              minWidth: viewportConstraints.maxWidth,
            ),
            child: Theme(
              data: ThemeData(
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
              child: context.watch<Searching>().isSearching
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        searchFilters(),
                        searchResultsText(),
                        filteredCoursesListView(),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        filterButtons(),
                        showFilters ? searchFilters() : const SizedBox.shrink(),
                        coursesListView(),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }

  Padding searchResultsText() {
    String searchTerm = context.watch<SearchTerm>().searchTerm;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
      child: Row(
        children: [
          const Icon(Icons.manage_search),
          const SizedBox(
            width: 5,
          ),
          Text("Search Results for $searchTerm in courses")
        ],
      ),
    );
  }

  Builder filterButtons() {
    final int courseCount = courses.length;
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
        child: Row(
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
                  onPressed: () {
                    setState(() {
                      showFilters = !showFilters;
                    });
                  },
                  icon: const Icon(Icons.filter_list),
                  label: const Text("Filter"),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Padding searchFilters() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
      child: SizedBox(
        height: 40,
        child: ListView(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: [
            CourseFilter(
              filterItems: courseType,
              hintText: "Course Type",
            ),
            const SizedBox(
              width: 8,
            ),
            CourseFilter(
              filterItems: courseCategory,
              hintText: "Category",
            ),
            const SizedBox(
              width: 8,
            ),
            CourseFilter(
              filterItems: level,
              hintText: "Level",
            ),
            const SizedBox(
              width: 8,
            ),
            CourseFilter(
              filterItems: mandatory,
              hintText: "Mandatory",
            ),
          ],
        ),
      ),
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

  Consumer filteredCoursesListView() {
    return Consumer<SearchTerm>(
      builder: (context, model, child) {
        List<Map<String, String>> filtered = [];
        if (model.searchTerm != "") {
          filtered = courses
              .where(
                (element) => element["title"]!.toLowerCase().contains(
                      model.searchTerm.toLowerCase(),
                    ),
              )
              .toList();
        }
        return ListView.builder(
          itemCount: filtered.length,
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, index) {
            final course = filtered[index];
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
            );
          },
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
          return Theme(
            data: ThemeData(
              canvasColor: Colors.transparent,
              colorScheme: Theme.of(context).colorScheme.copyWith(
                    primary: const Color.fromRGBO(27, 131, 139, 1),
                  ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            ),
            child: Wrap(
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
            ),
          );
        });
  }
}
