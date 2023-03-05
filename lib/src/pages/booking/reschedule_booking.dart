import 'package:booking_app/src/components/course/booking_stepper.dart';
import 'package:booking_app/src/pages/booking/book_course.dart';
import 'package:booking_app/src/pages/booking/select_new_date.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../components/course/course_tags.dart';
import '../../components/course/learning_types.dart';
import '../../util/resolve_header_color.dart';

class RescheduleBooking extends StatefulWidget {
  const RescheduleBooking({super.key});

  @override
  State<RescheduleBooking> createState() => _RescheduleBookingState();
}

class _RescheduleBookingState extends State<RescheduleBooking> {
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
      title: const Text("Reschedule a Booking"),
      backgroundColor: resolveAppHeaderColor(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appHeader(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Select a booking to reschedule"),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    // CourseDetail(course: item),
                                    SelectNewDate(
                                  course: course,
                                  bookingId: myBookings[index]["id"],
                                ),
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
        ));
  }
}
