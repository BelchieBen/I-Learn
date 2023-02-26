import 'package:flutter/material.dart';

class AccountTabs extends StatelessWidget {
  const AccountTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Column(
        children: [
          const TabBar(
            labelColor: Colors.black,
            indicatorColor: Color.fromRGBO(92, 199, 208, 1),
            tabs: <Widget>[
              Tab(
                text: "Learning Record",
              ),
              Tab(
                text: "Personal Details",
              ),
            ],
          ),
          SizedBox(
            height: 378,
            child: TabBarView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Courses Completed"),
                          Divider(),
                        ],
                      ),
                    ],
                  ),
                ),
                const Center(
                  child: Text("It's rainy here"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
