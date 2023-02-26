import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../components/account/account_tabs.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return Theme(
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
          Container(
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
          ),
          const AccountTabs(),
        ],
      ),
    );
  }
}
