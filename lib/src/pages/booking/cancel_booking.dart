import 'package:booking_app/src/components/course/course_tags.dart';
import 'package:booking_app/src/components/course/learning_types.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../util/resolve_header_color.dart';

class CancelBooking extends StatefulWidget {
  const CancelBooking({super.key});

  @override
  State<CancelBooking> createState() => _CancelBooking();
}

class _CancelBooking extends State<CancelBooking> {
  SupabaseClient supabase = Supabase.instance.client;
  List myBookings = [];
  bool loadingMyBookings = false;

  @override
  void initState() {
    super.initState();
    _fetchMyBookings();
  }

  void _fetchMyBookings() async {
    setState(() => loadingMyBookings = true);
    final List myBookingsResponse = await supabase
        .from("user_bookings")
        .select(
            "*, sessions(*,user_profile(*) ,courses(*,course_tags(id,tags(tag)), course_learning_types(id, learning_types(learning_type))))")
        .neq("status", "complete");
    setState(() {
      myBookings = myBookingsResponse;
      loadingMyBookings = false;
    });
  }

  AppBar appHeader() {
    return AppBar(
      title: const Text("Cancel a Booking"),
      backgroundColor: resolveAppHeaderColor(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appHeader(),
      body: Theme(
        data: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: const Color.fromRGBO(5, 109, 120, 1),
              ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Select a booking to cancel"),
                  const Divider(),
                  ListView.builder(
                    itemCount: myBookings.length,
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, index) {
                      final course = myBookings[index]["sessions"]["courses"];
                      return Card(
                        color: const Color.fromARGB(255, 250, 249, 252),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InkWell(
                          onTap: () {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                ),
                                title: const Text('Are you sure?'),
                                content: const Text('AlertDialog description'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Back'),
                                    child: const Text(
                                      'Back',
                                      style: TextStyle(
                                        color: Color.fromRGBO(5, 109, 120, 1),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => Navigator.pop(
                                        context, 'Cancel Booking'),
                                    child: const Text('Cancel Booking'),
                                  ),
                                ],
                              ),
                            );
                          },
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
                                          course["course_learning_types"]!,
                                    ),
                                    CourseTags(
                                      tags: course["course_tags"]!,
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
