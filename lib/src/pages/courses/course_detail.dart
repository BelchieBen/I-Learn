import 'package:booking_app/src/pages/booking/book_course.dart';
import 'package:flutter/material.dart';

class CourseDetailPage extends StatefulWidget {
  final Map<String, String> course;
  const CourseDetailPage({super.key, required this.course});

  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  bool showMore = false;

  final tableHeadings = [
    "Content",
    "Title",
    "Source",
    "Duration",
  ];

  final learningItems = [
    {
      "contentIcon": "Video.png",
      "content": "Video",
      "title": "Speak like a leader",
      "source": "Simon Lancaster, TEDx Talks",
      "duration": "19 mins"
    },
    {
      "contentIcon": "Video.png",
      "content": "Video",
      "title": "How to speak so that people want to listen",
      "source": "Julian Treasure, TED Talk",
      "duration": "10 mins"
    },
    {
      "contentIcon": "Article.png",
      "content": "Article",
      "title": "Effective Communication",
      "source": "ProofHub",
      "duration": "13 mins"
    },
    {
      "contentIcon": "TopTips.png",
      "content": "Quick Tips",
      "title": "Assertive communication - 6 Tips for effective use",
      "source": "Impact Factory",
      "duration": "5 mins"
    },
  ];

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
                    Text(
                      widget.course["title"]!,
                      style: const TextStyle(fontSize: 24),
                    ),
                    Padding(
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
                    ),
                    Padding(
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
                                        padding:
                                            EdgeInsets.fromLTRB(8, 0, 8, 0),
                                        child: Text(
                                          "|",
                                          style: TextStyle(
                                            color:
                                                Color.fromRGBO(200, 0, 99, 1),
                                          ),
                                        ),
                                      )
                                    : const Text(""),
                              ],
                            ),
                        ],
                      ),
                    ),
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
                    Padding(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Row(
                        children: [
                          const Icon(Icons.location_on_outlined),
                          Text(widget.course["location"]!)
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 4),
                      child: Text(
                        "Self Directed Learning",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    Table(
                      border: const TableBorder(
                        horizontalInside: BorderSide(
                          color: Color.fromRGBO(110, 120, 129, 1),
                        ),
                      ),
                      columnWidths: const <int, TableColumnWidth>{
                        0: IntrinsicColumnWidth(),
                        1: IntrinsicColumnWidth(),
                        2: IntrinsicColumnWidth(),
                        3: IntrinsicColumnWidth(),
                      },
                      children: <TableRow>[
                        TableRow(
                          children: [
                            for (var heading in tableHeadings)
                              TableCell(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                  child: Text(
                                    heading,
                                    style: const TextStyle(
                                      color: Color.fromRGBO(27, 131, 139, 1),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        for (var learningItem in learningItems)
                          TableRow(
                            children: [
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(4, 8, 4, 8),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "images/contentImages/${learningItem["contentIcon"]!}",
                                        height: 20,
                                        width: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Flexible(
                                          child:
                                              Text(learningItem["content"]!)),
                                    ],
                                  ),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(4, 8, 4, 8),
                                  child: Text(learningItem["title"]!),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(4, 8, 4, 8),
                                  child: Text(learningItem["source"]!),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(4, 8, 4, 8),
                                  child: Text(learningItem["duration"]!),
                                ),
                              ),
                            ],
                          )
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
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
                      child: Text("Book A Session"),
                    ),
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
}
