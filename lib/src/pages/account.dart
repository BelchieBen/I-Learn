import 'package:booking_app/src/components/account/account_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  static const coursesCompleted = [
    {
      "title": "Courageous Conversations",
      "image": "images/CompanyNews.png",
      "date": "20/04/2022 9:00",
      "tags": "Face to Face 1 Day,Suitable for everyone",
      "learningTypes": "FaceToFace.png,Podcast.png,TopTips.png,Article.png",
    },
    {
      "title": "Coaching",
      "image": "images/BackToWork.png",
      "date": "13/05/2022 9:00",
      "tags": "Face to Face 2 Days,Suitable for everyone",
      "learningTypes": "FaceToFace.png,Podcast.png,TopTips.png,Article.png",
    },
    {
      "title": "Computer Safety",
      "image": "images/CentralisedSafety Data.png",
      "date": "25/01/2023 9:00",
      "tags": "Face to Face 1 Day,Suitable for everyone",
      "learningTypes": "FaceToFace.png,Podcast.png,TopTips.png,Article.png",
    },
  ];

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
                const AccountTabs(
                  coursesCompleted: coursesCompleted,
                  currentPathwayProgression: currentPathwayProgression,
                  userInfo: userInfo,
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
        const Text(
          "Ben Belcher",
          style: TextStyle(fontSize: 24),
        ),
        const Text(
          "Technology Solutions Apprentice",
          style: TextStyle(
            color: Color.fromRGBO(93, 105, 119, 1),
          ),
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
