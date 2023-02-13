import 'package:booking_app/src/util/page_list.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int screenIndex = 0;
  late bool showNavigationDrawer;

  void handleScreenChanged(int selectedScreen) {
    print("Index");
    print(selectedScreen);
    print(pages.elementAt(selectedScreen));
    setState(() {
      screenIndex = selectedScreen;
    });
  }

  Widget buildAppScaffold() {
    return Scaffold(
      key: scaffoldKey,
      appBar: appHeader(),
      body: pageBody(),
      bottomNavigationBar: bottomNavBar(),
      drawer: sideNavDrawer(),
    );
  }

  AppBar appHeader() {
    return AppBar(
      title: const Text("I-Learn"),
    );
  }

  Center pageBody() {
    return Center(
      child: pages.elementAt(screenIndex),
    );
  }

  NavigationBar bottomNavBar() {
    return NavigationBar(
      selectedIndex: screenIndex,
      onDestinationSelected: (int index) {
        setState(() {
          screenIndex = index;
        });
      },
      destinations: pageDestinations.map((PageDestination page) {
        return NavigationDestination(
          label: page.label,
          icon: page.icon,
          selectedIcon: page.selectedIcon,
        );
      }).toList(),
    );
  }

  NavigationDrawer sideNavDrawer() {
    return NavigationDrawer(
      onDestinationSelected: handleScreenChanged,
      selectedIndex: screenIndex,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
          child: Text(
            'I-Learn',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        ...pageDestinations.map((PageDestination destination) {
          return NavigationDrawerDestination(
            label: Text(
              destination.label,
            ),
            icon: destination.icon,
          );
        }),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 0, 16, 10),
          child: Text(
            'Bookings',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        ...bookingDestinations.map((PageDestination destination) {
          return NavigationDrawerDestination(
            label: Text(
              destination.label,
            ),
            icon: destination.icon,
          );
        }),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 0, 16, 10),
          child: Text(
            'About & Contact',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        ...aboutDestinations.map((PageDestination destination) {
          return NavigationDrawerDestination(
            label: Text(
              destination.label,
            ),
            icon: destination.icon,
          );
        }),
      ],
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return buildAppScaffold();
  }
}
