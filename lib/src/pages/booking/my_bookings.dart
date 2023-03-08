import 'package:booking_app/src/components/course/learning_types.dart';
import 'package:booking_app/src/pages/booking/select_new_date.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Page to display all bookings associated with a user
class MyBookings extends StatefulWidget {
  const MyBookings({super.key});

  @override
  State<MyBookings> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBookings> {
  SupabaseClient supabase = Supabase.instance.client;
  List myBookings = [];
  bool loadingMyBookings = false;
  bool showCancelled = false;

  var loggerNoStack = Logger(
    printer: PrettyPrinter(methodCount: 0),
  );

  @override
  void initState() {
    super.initState();
    final supabase = Supabase.instance.client;
    _fetchMyBookings(supabase);
  }

  // Method to fetch bookings for the current user
  void _fetchMyBookings(SupabaseClient supabase) async {
    setState(() => loadingMyBookings = true);
    // Conditional to change the db query depending if the user wants to see thier cancelled bookings
    if (showCancelled) {
      // Supabase db query to retrieve users cancelled bookings and active bookings
      final List myBookingsResponse = await supabase
          .from("user_bookings")
          .select(
              "*, sessions(*,user_profile(*) ,courses(*,course_tags(id,tags(tag)), course_learning_types(id, learning_types(learning_type))))")
          .neq("status", "complete")
          .order("created_at");

      setState(() {
        myBookings = myBookingsResponse;
        loadingMyBookings = false;
      });
    } else {
      // Supabase db query to retrieve users active bookings
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
  }

  // Method to get the colour of the status label depending on the status
  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "approved":
        return const Color.fromRGBO(30, 223, 146, 1);
      case "pending":
        return const Color.fromRGBO(38, 71, 218, 1);
      case "declined":
        return const Color.fromRGBO(226, 45, 56, 1);
      case "cancelled":
        return const Color.fromRGBO(47, 64, 81, 1);
      default:
        return const Color.fromRGBO(255, 255, 255, 1);
    }
  }

  // Method to cancel a booking, called when the cancel button is tapped on a bookoing card.
  _cancelBooking(id) async {
    await supabase
        .from("user_bookings")
        .update({"status": "Cancelled"}).match({"id": id});
    _fetchMyBookings(supabase);
  }

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
                    primary: const Color.fromRGBO(27, 131, 139, 1),
                  ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                myBookingsHeading(),
                // Dynamic rendering with loading state
                loadingMyBookings
                    ? const SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Color.fromRGBO(5, 109, 120, 1),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                // Check if there are no bookings, if so display empty infographic
                myBookings.isEmpty && !loadingMyBookings
                    ? SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            Image.asset("images/empty.png", width: 250),
                            const Text("No Items",
                                style: TextStyle(fontSize: 18))
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
                for (var booking in myBookings) bookingCard(booking),
              ],
            ),
          ),
        ),
      );
    });
  }

  // Component to display the page title, divider and button to toggle
  // between showing cancelled bookings and only active bookings
  Padding myBookingsHeading() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("My Bookings"),
          const Divider(),
          TextButton(
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            onPressed: () {
              setState(() => showCancelled = !showCancelled);
              _fetchMyBookings(supabase);
            },
            child: Text(showCancelled ? "Hide Cancelled" : "Show Cancelled"),
          ),
        ],
      ),
    );
  }

  Padding bookingCard(Map<String, dynamic> booking) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    booking["sessions"]["courses"]["title"]!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 90,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: getStatusColor(booking["status"]!),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        booking["status"]!,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
              const Divider(),
              Row(
                children: [
                  Image.asset(
                    booking["sessions"]["courses"]["image"]!,
                    height: 120,
                    width: 120,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking["sessions"]["courses"]["title"]!,
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        booking["sessions"]["start_date"]!,
                        style: const TextStyle(fontSize: 13),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.person,
                            size: 18,
                            color: Color.fromRGBO(139, 147, 151, 1),
                          ),
                          Text(
                            booking["sessions"]["user_profile"]["full_name"]!,
                            style: const TextStyle(
                              color: Color.fromRGBO(139, 147, 151, 1),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 18,
                            color: Color.fromRGBO(139, 147, 151, 1),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            booking["sessions"]["courses"]["location"]!,
                            style: const TextStyle(
                              color: Color.fromRGBO(139, 147, 151, 1),
                            ),
                          ),
                        ],
                      ),
                      LearningTypes(
                        contentTypes: booking["sessions"]["courses"]
                            ["course_learning_types"]!,
                      ),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: booking["status"]! == "Cancelled"
                        ? null
                        : () {
                            _cancelBooking(booking["id"]!);
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(244, 245, 246, 1),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: Color.fromRGBO(33, 45, 56, 1),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectNewDate(
                            course: booking["sessions"]["courses"]!,
                            bookingId: booking["id"]!,
                          ),
                        ),
                      );
                    },
                    child: const Text("Reschedule"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
