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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Select a booking to reschedule"),
                        Divider(),
                      ],
                    ),
                  ),
                  loadingMyBookings
                      ? const SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Color.fromRGBO(5, 109, 120, 1),
                            ),
                          ),
                        )
                      : myBookings.isEmpty && !loadingMyBookings
                          ? Center(
                              child: Column(
                                children: [
                                  const SizedBox(height: 50),
                                  Image.asset("images/empty.png", width: 250),
                                  const Text("No Bookings to Reschedule")
                                ],
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: ListView.builder(
                                itemCount: myBookings.length,
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, index) {
                                  final course =
                                      myBookings[index]["sessions"]["courses"];
                                  return Card(
                                    color: const Color.fromARGB(
                                        255, 250, 249, 252),
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
                                              bookingId: myBookings[index]
                                                  ["id"],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  course["title"]!,
                                                  style: const TextStyle(
                                                      fontSize: 18),
                                                ),
                                                Text(
                                                  myBookings[index]["sessions"]
                                                      ["start_date"]!,
                                                  style: const TextStyle(
                                                      fontSize: 13),
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.person,
                                                      size: 18,
                                                      color: Color.fromRGBO(
                                                          139, 147, 151, 1),
                                                    ),
                                                    Text(
                                                      myBookings[index]
                                                                  ["sessions"]
                                                              ["user_profile"]
                                                          ["full_name"]!,
                                                      style: const TextStyle(
                                                        color: Color.fromRGBO(
                                                            139, 147, 151, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.location_on,
                                                      size: 18,
                                                      color: Color.fromRGBO(
                                                          139, 147, 151, 1),
                                                    ),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(
                                                      myBookings[index]
                                                                  ["sessions"]
                                                              ["courses"]
                                                          ["location"]!,
                                                      style: const TextStyle(
                                                        color: Color.fromRGBO(
                                                            139, 147, 151, 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                LearningTypes(
                                                  contentTypes: course[
                                                      "course_learning_types"]!,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                ],
              ),
            ],
          ),
        ));
  }
}
