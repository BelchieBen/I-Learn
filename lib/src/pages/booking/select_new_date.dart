import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../components/scaffold/app_scaffold.dart';
import '../../util/resolve_header_color.dart';

// Page to list all session dates available for a course
class SelectNewDate extends StatefulWidget {
  final Map<String, dynamic> course;
  final int bookingId;
  const SelectNewDate({
    super.key,
    required this.course,
    required this.bookingId,
  });

  @override
  State<SelectNewDate> createState() => _SelectNewDateState();
}

class _SelectNewDateState extends State<SelectNewDate> {
  SupabaseClient supabase = Supabase.instance.client;
  int selectedDateIndex = 0;
  List dates = [];

  // Loading states
  bool loadingSessions = false;
  bool reschedulingBooking = false;

  @override
  void initState() {
    super.initState();
    SupabaseClient supabase = Supabase.instance.client;
    _fetchCourseSessions(supabase);
  }

  // Method to fetch course sessions from Supabase db using the course id passed to the page
  void _fetchCourseSessions(SupabaseClient supabase) async {
    setState(() => loadingSessions = true);
    final sessions = await supabase
        .from("sessions")
        .select("*")
        .filter("course_id", "eq", widget.course["id"]!);

    // Updates the sessions list and loading state
    setState(() {
      dates = sessions;
      loadingSessions = false;
    });
  }

  // Method to update a users booking with the new date they selected
  void _rescheduleBooking() async {
    setState(() => reschedulingBooking = true);
    // Send update request to Supabase db to update the user booking with new date
    final response = await supabase.from("user_bookings").update({
      "session": dates[selectedDateIndex]["id"]!,
    }).match({"id": widget.bookingId});

    setState(() => reschedulingBooking = false);

    // Once the update has succeeded show a snackbar to the user and navigate back to the homepage
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        successSnackbar(),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AppScaffold(),
        ),
      );
    }
  }

  AppBar appHeader() {
    return AppBar(
        title: const Text("Select a Date"),
        backgroundColor: resolveAppHeaderColor());
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
        child: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                  maxHeight: viewportConstraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    // Dynamic rendering with loading state
                    loadingSessions
                        ? const SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                                color: Color.fromRGBO(5, 109, 120, 1),
                              ),
                            ),
                          )

                        // Also check if we have recieved no available sessions from the db. Show a empty infographic
                        : dates.isEmpty && !loadingSessions
                            ? const SizedBox(
                                width: double.infinity,
                                child: Center(
                                    child: Text("No Sessions Available")),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: dates.isEmpty ? 0 : dates.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                    ),

                                    // Doing some string manipulation as the dates and times are stored in multiple columns in the db
                                    // and the format from Supabase is not what I want to display to users
                                    title: Text(dates[index]["start_date"]! +
                                        ": " +
                                        dates[index]["start_time"]!
                                            .substring(0, 5) +
                                        " - " +
                                        dates[index]["end_date"]! +
                                        ": " +
                                        dates[index]["end_time"]!
                                            .substring(0, 5)),
                                    trailing: selectedDateIndex == index
                                        ? const Icon(
                                            Icons.check_circle_outline,
                                            color:
                                                Color.fromRGBO(92, 199, 208, 1),
                                          )
                                        : null,
                                    tileColor: selectedDateIndex == index
                                        ? const Color.fromRGBO(210, 246, 250, 1)
                                        : null,
                                    onTap: () {
                                      setState(() {
                                        selectedDateIndex = index;
                                      });
                                    },
                                  );
                                },
                              ),
                    const SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          _rescheduleBooking();
                        },
                        child: reschedulingBooking
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 1,
                                  color: Colors.white,
                                ),
                              )
                            : const Text("Reschedule"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // The success snackbar that is shown when a booking is rescheduled successfully.
  // It is a customised Material snackbar using the Helix colours.
  SnackBar successSnackbar() {
    return SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      content: Container(
        padding: const EdgeInsets.all(16),
        height: 60,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 184, 110, 1),
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(
              Icons.check_circle_outline,
              color: Color.fromRGBO(167, 251, 217, 1),
            ),
            SizedBox(width: 6),
            Text("Booking Updated"),
          ],
        ),
      ),
    );
  }
}
