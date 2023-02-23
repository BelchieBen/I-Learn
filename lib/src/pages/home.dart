import 'package:booking_app/src/pages/booking/book_course.dart';
import 'package:booking_app/src/pages/courses/course_detail.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final recomendedItems = [
    {
      "title": "Time Management",
      "image": "images/FastEasyReporting.png",
      "altText": "16 Lessons",
      "description":
          "Time management enables each of us to improve and be more productive and fulfilled individually, so logically the effects across whole organisations of good or poor time management are enormous. In fact, a 2007 survey of 2500 businesses over a four-year period indicated that on average wasted time cost UK businesses £80bn per year! Save time and money by learning how to properly plan and protect your time!",
      "quoteText":
          "I apply most of the techniques I learnt in training in both my personal and professional life",
      "tags": "Duration: 2 Hours,Maximum Attendees: 12,Suitable for everyone",
      "learningContents": "FaceToFace.png,Podcast.png,TopTips.png,Article.png",
      "location": "Ruddington",
      "showBookBtn": "true",
    },
    {
      "title": "Coaching",
      "image": "images/BackToWork.png",
      "altText": "8 Lessons",
      "description":
          "Coaching is a useful way of developing people's skills and abilities, and of boosting performance. It can also help deal with issues and challenges before they become major problems. Coaches in the workplace do not have to be counsellors, therapists, or trainers – they simply facilitate learning.",
      "quoteText":
          "Coaching is releasing a person's potential to maximise their own performance. It is helping them to learn rather than teaching them",
      "tags": "Duration: 4 Hours,Maximum Attendees: 12,Suitable for everyone",
      "learningContents": "FaceToFace.png,Article.png,Podcast.png",
      "location": "Ruddington",
      "showBookBtn": "true",
    },
    {
      "title": "Communication Skills",
      "image": "images/ConflictResolution.png",
      "altText": "1 Day In Person",
      "description":
          "Communication and assertiveness are vital both in our personal and our professional lives. Not only does effective communication allow us to be more productive and efficient, it also helps us develop strong working relationships, essential for developing trust. How we communicate affects both our colleagues and our customers. Effective communication could even be the difference between closing a sale and missing out!",
      "quoteText":
          "I found it very useful to go through the different scenarios and apply the 'assertive', 'passive' and'aggressive' communication types to anticipate the responses. It helped me to understand how to frame my response in an 'assertive' way to get the best result.",
      "tags": "Duration: 1 Day,Maximum Attendees: 12,Suitable for everyone",
      "learningContents": "FaceToFace.png,Video.png,Article.png,TopTips.png",
      "location": "Ruddington",
      "showBookBtn": "true",
    },
    {
      "title": "Presentation Skills",
      "image": "images/AutomatedRecordKeeping.png",
      "altText": "1 Day In Person",
      "description":
          "Most of us feel uncomfortable or nervous when asked to present, yet at some point during our careers, we will all have to do it. Anyone can give a good presentation, all it takes are some key tools and techniques and most important of all, good preparation and practise! Here we aim not only to develop your presentation ability but also equip you with some key tools to manage your confidence and give compelling presentations!",
      "quoteText":
          "I have already noticed a difference in my presentations and the trainer provided further tools to support in my role. The training has given me the tools I need to deliver effective presentations and enable my confidence to grow when I find myself faced with this type of task.",
      "tags": "Duration: 1 Day,Maximum Attendees: 6,Suitable for everyone",
      "learningContents": "FaceToFace.png,Video.png,Article.png",
      "location": "Pre-Recorded Sessions",
      "showBookBtn": "true",
    },
  ];

  final upcomingItems = [
    {
      "title": "COSHH Training",
      "image": "images/COSHH.png",
      "location": "Ruddington",
      "altText": "30-03-2022 9:00 - 30-03-2022 17:00",
      "description":
          "Time management enables each of us to improve and be more productive and fulfilled individually, so logically the effects across whole organisations of good or poor time management are enormous. In fact, a 2007 survey of 2500 businesses over a four-year period indicated that on average wasted time cost UK businesses £80bn per year! Save time and money by learning how to properly plan and protect your time!",
      "quoteText":
          "I apply most of the techniques I learnt in training in both my personal and professional life",
      "tags": "Duration: 2 Hours,Maximum Attendees: 12,Suitable for everyone",
      "learningContents": "FaceToFace.png,Podcast.png,TopTips.png,Article.png",
    },
    {
      "title": "Health & Safety",
      "image": "images/FirstAid.png",
      "location": "MS Teams",
      "altText": "20-03-2022 9:00 - 23-03-2022 17:00",
      "description":
          "Time management enables each of us to improve and be more productive and fulfilled individually, so logically the effects across whole organisations of good or poor time management are enormous. In fact, a 2007 survey of 2500 businesses over a four-year period indicated that on average wasted time cost UK businesses £80bn per year! Save time and money by learning how to properly plan and protect your time!",
      "quoteText":
          "I apply most of the techniques I learnt in training in both my personal and professional life",
      "tags": "Duration: 2 Hours,Maximum Attendees: 12,Suitable for everyone",
      "learningContents": "FaceToFace.png,Podcast.png,TopTips.png,Article.png",
    },
    {
      "title": "Food Heigine",
      "image": "images/FoodSafetyLevel.png",
      "location": "Ruddington",
      "altText": "09-03-2022 9:00 - 09-03-2022 11:00",
      "description":
          "Time management enables each of us to improve and be more productive and fulfilled individually, so logically the effects across whole organisations of good or poor time management are enormous. In fact, a 2007 survey of 2500 businesses over a four-year period indicated that on average wasted time cost UK businesses £80bn per year! Save time and money by learning how to properly plan and protect your time!",
      "quoteText":
          "I apply most of the techniques I learnt in training in both my personal and professional life",
      "tags": "Duration: 2 Hours,Maximum Attendees: 12,Suitable for everyone",
      "learningContents": "FaceToFace.png,Podcast.png,TopTips.png,Article.png",
    },
    {
      "title": "Asbestos Awareness",
      "image": "images/AsbestosAwareness.png",
      "location": "Pre-Recorded Sessions",
      "altText": "24-03-2022 9:00 - 25-03-2022 17:00",
      "description":
          "Time management enables each of us to improve and be more productive and fulfilled individually, so logically the effects across whole organisations of good or poor time management are enormous. In fact, a 2007 survey of 2500 businesses over a four-year period indicated that on average wasted time cost UK businesses £80bn per year! Save time and money by learning how to properly plan and protect your time!",
      "quoteText":
          "I apply most of the techniques I learnt in training in both my personal and professional life",
      "tags": "Duration: 2 Hours,Maximum Attendees: 12,Suitable for everyone",
      "learningContents": "FaceToFace.png,Podcast.png,TopTips.png,Article.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Recomended for you"),
                  const Divider(),
                  Align(
                    alignment: Alignment.center,
                    child: Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      children: [
                        for (var item in recomendedItems)
                          FractionallySizedBox(
                            widthFactor: 0.49,
                            child: Card(
                              color: Colors.white,
                              clipBehavior: Clip.none,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          // CourseDetail(course: item),
                                          CourseDetailPage(course: item),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 12),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        item["image"]!,
                                        width: 140,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(item["title"]!),
                                          Text(
                                            item["altText"]!,
                                            style:
                                                const TextStyle(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text("Your upcoming courses"),
                  const Divider(),
                  for (var item in upcomingItems)
                    ListTile(
                      leading: Image.asset(
                        item["image"]!,
                        width: 60,
                      ),
                      title: Text(item["title"]!),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item["altText"]!),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 18,
                                color: Color.fromRGBO(139, 147, 151, 1),
                              ),
                              Text(
                                item["location"]!,
                                style: const TextStyle(
                                  color: Color.fromRGBO(139, 147, 151, 1),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                // CourseDetail(course: item),
                                CourseDetailPage(course: item),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
