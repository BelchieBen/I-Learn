import 'package:booking_app/src/components/account/account_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  void _fetchUserProfile(SupabaseClient supabase) async {
    setState(() => loadingAccount = true);
    var currentUserId = supabase.auth.currentUser?.id;
    if (currentUserId != null || currentUserId != "") {
      final profileResponse = await supabase
          .from("user_profile")
          .select("*")
          .filter("user_id", "eq", currentUserId)
          .single();

      loggerNoStack.v(profileResponse);
      setState(() {
        userProfile = profileResponse;
        loadingAccount = false;
      });
    }
  }

  void _fetchCompletedCourses(SupabaseClient supabase) async {
    var currentUserId = supabase.auth.currentUser?.id;
    if (currentUserId != null || currentUserId != "") {
      final coursesCompletedResponse = await supabase
          .from("user_bookings")
          .select(
              "*, sessions(*,courses(*,course_tags(id,tags(tag)), course_learning_types(id, learning_types(learning_type))))")
          .filter("employee", "eq", currentUserId)
          .filter('status', 'eq', 'complete');
      loggerNoStack.v(coursesCompletedResponse);

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

  static const userInfo = {
    "employeeId": "123456",
    "name": "Ben Belcher",
    "email": "benjamin.belcher@ideagen.com",
    "phoneNumber": "09765434567",
    "dob": "01/01/2000",
  };

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
