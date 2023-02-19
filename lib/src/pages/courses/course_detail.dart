import 'package:flutter/material.dart';
import '../../components/inputs/text_form_input.dart';

class CourseDetail extends StatefulWidget {
  final Map<String, String> course;
  const CourseDetail({
    super.key,
    required this.course,
  });

  @override
  State<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AppBar appHeader() {
    return AppBar(
      title: const Text("Book a Session"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appHeader(),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Wrap(
                    children: [
                      Image.asset(
                        widget.course["image"]!,
                        width: 180,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.course["title"]!,
                                style: const TextStyle(fontSize: 18)),
                            Text(widget.course["altText"]!),
                            const Text("Virtual Online: Not available"),
                            const Text("Suitable for everyone"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("24-02-2022 9:00 - 24-02-2022 17:00 "),
                      TextButton(
                        onPressed: () {
                          print("Change Pressed");
                        },
                        child: const Text(
                          "Change",
                          style:
                              TextStyle(color: Color.fromRGBO(27, 131, 139, 1)),
                        ),
                      ),
                    ],
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextFormInput(
                          labelText: "How has this training been identified?",
                          numLines: 3,
                        ),
                        const TextFormInput(
                          labelText:
                              "How will you apply the learning in your role?",
                          numLines: 3,
                        ),
                        const TextFormInput(
                          labelText:
                              "How will you measure the success of this learning?",
                          numLines: 3,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Validate will return true if the form is valid, or false if
                            // the form is invalid.
                            if (_formKey.currentState!.validate()) {
                              // Process data.
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
