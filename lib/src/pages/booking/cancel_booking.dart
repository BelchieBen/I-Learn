import 'package:booking_app/src/components/course/course_tags.dart';
import 'package:booking_app/src/components/course/learning_types.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../util/resolve_header_color.dart';

// Page to view a list of active bookings and cancel the sessions
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

  // Method to fetch the current users active bookings
  void _fetchMyBookings() async {
    setState(() => loadingMyBookings = true);
    final List myBookingsResponse = await supabase
        .from("user_bookings")
        .select(
            "*, sessions(*,user_profile(*) ,courses(*,course_tags(id,tags(tag)), course_learning_types(id, learning_types(learning_type))))")
        .neq("status", "complete")
        .neq("status", "Cancelled")
        .order("created_at");
    setState(() {
      myBookings = myBookingsResponse;
      loadingMyBookings = false;
    });
  }

  // Method to cancel a booking, I do a 'soft delete' on
  // the booking so users can still see/ reschedule the session.
  _cancelBooking(id) async {
    await supabase
        .from("user_bookings")
        .update({"status": "Cancelled"}).match({"id": id});
    _fetchMyBookings();
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Select a booking to cancel"),
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
                                const Text("No Bookings to Cancel")
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
                                  color:
                                      const Color.fromARGB(255, 250, 249, 252),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      // Display a popup dialog to make the user confirm the cancellation
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(16),
                                            ),
                                          ),
                                          title: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: const [
                                              Icon(Icons.error_outline,
                                                  color: Color.fromRGBO(
                                                      226, 45, 56, 1)),
                                              SizedBox(width: 5),
                                              Text(
                                                'Please Confirm',
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      226, 45, 56, 1),
                                                ),
                                              ),
                                            ],
                                          ),
                                          content: Text(
                                              'Cancel your booking for ' +
                                                  course["title"]!),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Back'),
                                              child: const Text(
                                                'Back',
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      5, 109, 120, 1),
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                _cancelBooking(
                                                    myBookings[index]["id"]!);
                                                Navigator.pop(
                                                    context, 'Cancel Booking');
                                              },
                                              child:
                                                  const Text('Cancel Booking'),
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
      ),
    );
  }
}
