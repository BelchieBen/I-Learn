import 'package:flutter/material.dart';

// Component to render the table on each Course Detail Page, showing the course learning types and thier sourses
class SelfDirectedLearningTable extends StatefulWidget {
  const SelfDirectedLearningTable({super.key});

  State<SelfDirectedLearningTable> createState() =>
      _SelfDirectedLearningTableState();
}

class _SelfDirectedLearningTableState extends State<SelfDirectedLearningTable> {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
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
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
                      child: Row(
                        children: [
                          Image.asset(
                            "images/contentImages/${learningItem["contentIcon"]!}",
                            height: 20,
                            width: 20,
                          ),
                          const SizedBox(width: 8),
                          Flexible(child: Text(learningItem["content"]!)),
                        ],
                      ),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
                      child: Text(learningItem["title"]!),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
                      child: Text(learningItem["source"]!),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
                      child: Text(learningItem["duration"]!),
                    ),
                  ),
                ],
              )
          ],
        ),
      ],
    );
  }
}
