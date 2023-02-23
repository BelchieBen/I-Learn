import 'package:booking_app/src/components/course/self_directed_learning_table.dart';
import 'package:booking_app/src/pages/booking/book_course.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

class CourseDetailPage extends StatefulWidget {
  final Map<String, String> course;
  const CourseDetailPage({super.key, required this.course});

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  bool showMore = false;

  AppBar appHeader() {
    return AppBar(
      title: const Text("Course Information"),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tags = widget.course["tags"]!.split(",");
    final contentTypes = widget.course["learningContents"]!.split(",");
    final quoteText = widget.course["quoteText"]!;

    print(widget.course["showBookBtn"]);

    return Scaffold(
      appBar: appHeader(),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
              child: Theme(
                data: ThemeData(
                  canvasColor: Colors.transparent,
                  colorScheme: Theme.of(context).colorScheme.copyWith(
                        primary: const Color.fromRGBO(27, 131, 139, 1),
                        secondary: const Color.fromRGBO(182, 187, 193, 1),
                      ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    courseTitle(),
                    learningTypes(contentTypes),
                    courseTags(tags),
                    courseDescription(),
                    courseQuote(quoteText),
                    courseLocation(),
                    const SelfDirectedLearningTable(),
                    const SizedBox(height: 16),
                    widget.course["showBookBtn"] != null
                        ? bookSessionButton(context)
                        : const SizedBox(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Text courseTitle() {
    return Text(
      widget.course["title"]!,
      style: const TextStyle(fontSize: 24),
    );
  }

  Padding learningTypes(List<String> contentTypes) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: Wrap(
        spacing: 8,
        children: [
          for (var type in contentTypes)
            Image.asset(
              "images/contentImages/$type",
              height: 25,
            ),
        ],
      ),
    );
  }

  Padding courseTags(List<String> tags) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
      child: Wrap(
        children: [
          for (var tag in tags)
            Wrap(
              children: [
                Text(
                  tag,
                  style: const TextStyle(
                    color: Color.fromRGBO(200, 0, 99, 1),
                  ),
                ),
                tag != tags.last
                    ? const Padding(
                        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Text(
                          "|",
                          style: TextStyle(
                            color: Color.fromRGBO(200, 0, 99, 1),
                          ),
                        ),
                      )
                    : const Text(""),
              ],
            ),
        ],
      ),
    );
  }

  Column courseDescription() {
    return Column(
      children: [
        Text(
          widget.course["description"]!,
          maxLines: showMore ? 100 : 5,
          textAlign: TextAlign.justify,
          overflow: TextOverflow.ellipsis,
        ),
        Container(
          alignment: Alignment.bottomRight,
          padding: const EdgeInsets.all(6),
          child: GestureDetector(
            child: Text(
              showMore ? "Read less" : "Read more",
              style: const TextStyle(
                color: Color.fromRGBO(27, 131, 139, 1),
              ),
            ),
            onTap: () {
              setState(() {
                showMore = !showMore;
              });
            },
          ),
        ),
      ],
    );
  }

  Padding courseQuote(String quoteText) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: IntrinsicHeight(
        child: Row(children: [
          const VerticalDivider(
            thickness: 2,
            color: Color.fromRGBO(27, 131, 139, 1),
          ),
          Flexible(
            child: Text(
              "“$quoteText”",
              style: const TextStyle(
                color: Color.fromRGBO(27, 131, 139, 1),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Padding courseLocation() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: Row(
        children: [
          const Icon(Icons.location_on_outlined),
          Text(widget.course["location"]!)
        ],
      ),
    );
  }

  ElevatedButton bookSessionButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                // CourseDetail(course: item),
                CourseBookingPage(course: widget.course),
          ),
        );
      },
      child: const Text("Book A Session"),
    );
  }
}
