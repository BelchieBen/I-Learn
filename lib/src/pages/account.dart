import 'package:booking_app/src/components/account/account_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// This widget is the account page, multiple sub-widgets are used in this widget
// to make-up the page.
class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  List coursesCompleted = [];
  Map<String, dynamic> userProfile = {};

  bool loadingAccount = false;

  var loggerNoStack = Logger(
    printer: PrettyPrinter(methodCount: 0),
  );

  @override
  void initState() {
    super.initState();
    SupabaseClient supabase = Supabase.instance.client;
    print(supabase.auth.currentUser?.id);
    _fetchCompletedCourses(supabase);
    _fetchUserProfile(supabase);
  }

  // Private method to get the user profile from Supabase db, it first validates if we have
  // an authenticated user and then queries the db for a user matching the current user's ID
  void _fetchUserProfile(SupabaseClient supabase) async {
    // Loading state to control when to display an indicator
    setState(() => loadingAccount = true);
    var currentUserId = supabase.auth.currentUser?.id;
    if (currentUserId != null || currentUserId != "") {
      final profileResponse = await supabase
          .from("user_profile")
          .select("*")
          .filter("user_id", "eq", currentUserId)
          .single();

      setState(() {
        userProfile = profileResponse;
        loadingAccount = false;
      });
    }
  }

  // Private method to fetch the courses a user has completed from Supabase db, again I
  // validate if we have a current user and query multiple tables through foreign keys
  // to get the information needed to make up the card.
  void _fetchCompletedCourses(SupabaseClient supabase) async {
    var currentUserId = supabase.auth.currentUser?.id;
    if (currentUserId != null || currentUserId != "") {
      final coursesCompletedResponse = await supabase
          .from("user_bookings")
          .select(
              "*, sessions(*,courses(*,course_tags(id,tags(tag)), course_learning_types(id, learning_types(learning_type))))")
          .filter("employee", "eq", currentUserId)
          .filter('status', 'eq', 'complete');

      setState(() {
        coursesCompleted = coursesCompletedResponse;
      });
    }
  }

  static const currentPathwayProgression = [
    {
      "title": "COSHH Training",
      "image": "images/COSHH.png",
      "pathwayStep": "1",
      "steps": "Basics,Intermediate,Expert",
    },
    {
      "title": "Coaching",
      "image": "images/BackToWork.png",
      "pathwayStep": "2",
      "steps": "Basics,Intermediate,Expert",
    },
    {
      "title": "Computer Safety",
      "image": "images/CentralisedSafety Data.png",
      "pathwayStep": "3",
      "steps": "Intermediate,Advanced,Expert",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
              minWidth: viewportConstraints.maxWidth,
              maxWidth: viewportConstraints.maxWidth),
          // Wrapping the page in a theme to customise the colours over the default theme I set
          child: Theme(
            data: ThemeData(
              colorScheme: Theme.of(context).colorScheme.copyWith(
                    primary: const Color.fromRGBO(27, 131, 139, 1),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                accountProfile(),
                AccountTabs(
                  currentPathwayProgression: currentPathwayProgression,
                  userInfo: userProfile,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  // Component to display the header section in the accounts page, showing the users
  // full name, job title and profile photo.
  Container accountProfile() {
    return Container(
      height: 250,
      color: const Color.fromRGBO(228, 252, 255, 1),
      child: Column(children: [
        const Spacer(),
        loadingAccount
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                ),
              )
            : Column(
                children: [
                  Text(
                    userProfile["full_name"]!,
                    style: const TextStyle(fontSize: 24),
                  ),
                  Text(
                    userProfile["job_title"]!,
                    style: const TextStyle(
                      color: Color.fromRGBO(93, 105, 119, 1),
                    ),
                  ),
                ],
              ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SvgPicture.asset("images/books.svg"),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "https://cdn.pixabay.com/photo/2016/11/29/03/15/man-1867009_960_720.jpg"),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              SvgPicture.asset("images/booksRight.svg"),
            ],
          ),
        )
      ]),
    );
  }
}
