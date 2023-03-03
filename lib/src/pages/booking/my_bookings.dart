import 'package:booking_app/src/components/course/learning_types.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyBookings extends StatefulWidget {
  const MyBookings({super.key});

  @override
  State<MyBookings> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBookings> {
  List<Map<String, dynamic>> myBookings = [];
  @override
  void initState() {
    super.initState();
    final supabase = Supabase.instance.client;
    _fetchMyBookings(supabase);
  }

  void _fetchMyBookings(SupabaseClient supabase) async {
    final myBookingsResponse = await supabase
        .from("user_bookings")
        .select("*,employee(*), session(*)");
    setState(() {
      myBookings = myBookingsResponse.toList();
    });
  }

  // final List<Map<String, String>> myBookings = [
  //   {
  //     "title": "Courageous Conversations",
  //     "image": "images/CompanyNews.png",
  //     "status": "Approved",
  //     "date": "20/04/2022 9:00",
  //     "trainer": "Callum Davidson",
  //     "location": "Ruddington",
  //     "learningTypes": "FaceToFace.png,Podcast.png,TopTips.png,Article.png",
  //   },
  //   {
  //     "title": "Delegation",
  //     "image": "images/Collaboration.png",
  //     "status": "Pending",
  //     "date": "26/09/2022 13:30",
  //     "trainer": "Jo Harris",
  //     "location": "Ruddington",
  //     "learningTypes": "FaceToFace.png,Podcast.png,TopTips.png,Article.png",
  //   },
  //   {
  //     "title": "Food Safety",
  //     "image": "images/FoodSafetyLevel.png",
  //     "status": "Declined",
  //     "date": "04/07/2022 11:00",
  //     "trainer": "Rebecca Jackson",
  //     "location": "MS Teams",
  //     "learningTypes": "FaceToFace.png,Podcast.png,TopTips.png,Article.png",
  //   },
  // ];

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "approved":
        return const Color.fromRGBO(30, 223, 146, 1);
      case "pending":
        return const Color.fromRGBO(38, 71, 218, 1);
      case "declined":
        return const Color.fromRGBO(226, 45, 56, 1);
      default:
        return const Color.fromRGBO(255, 255, 255, 1);
    }
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
                for (var booking in myBookings) bookingCard(booking),
              ],
            ),
          ),
        ),
      );
    });
  }

  Padding myBookingsHeading() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("My Bookings"),
          Divider(),
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
                    booking["title"]!,
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
                    booking["image"]!,
                    height: 120,
                    width: 120,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking["title"]!,
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        booking["date"]!,
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
                            booking["trainer"]!,
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
                            booking["location"]!,
                            style: const TextStyle(
                              color: Color.fromRGBO(139, 147, 151, 1),
                            ),
                          ),
                        ],
                      ),
                      LearningTypes(
                        contentTypes:
                            booking["learningTypes"]!.split(",").toList(),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
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
                    onPressed: () {},
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
