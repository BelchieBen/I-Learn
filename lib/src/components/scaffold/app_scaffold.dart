import 'package:booking_app/providers/search_term.dart';
import 'package:booking_app/providers/searching.dart';
import 'package:booking_app/src/pages/auth/login.dart';
import 'package:booking_app/src/pages/auth/register.dart';
import 'package:booking_app/src/util/page_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../util/resolve_header_color.dart';

// This component is the base app scaffold, including the bottom nav bar and the side drawer that displays on every page.
class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  SupabaseClient supabase = Supabase.instance.client;
  SharedPreferences? preferences;

  void _initPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      preferences = prefs;
    });
  }

  @override
  void initState() {
    super.initState();
    _initPreferences();
  }

  int screenIndex = 0;
  late bool showNavigationDrawer;

  // Method to change which page is displayed when the user taps an item in either the bottom nav bar or side drawer
  void handleScreenChanged(int selectedScreen) {
    // Validate if the screen selected is valid. There is only 4 pages in the base horizontal navigation layer.
    if (selectedScreen < 4) {
      setState(() {
        screenIndex = selectedScreen;
      });
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => pages.elementAt(selectedScreen),
        ),
      );
    }
  }

  // Small component to build the overall app scaffold
  Widget buildAppScaffold() {
    return Scaffold(
      key: scaffoldKey,
      appBar: appHeader(),
      body: pageBody(),
      bottomNavigationBar: bottomNavBar(),
      drawer: sideNavDrawer(),
    );
  }

  // A widget for the top app bar, changes the UI depending on global state.
  AppBar appHeader() {
    return AppBar(
        // When the user is searching on the Search Courses Page, render a text field
        // and change the leading icon from the hamburger to a back arrow
        title: context.watch<Searching>().isSearching
            ? TextField(
                onChanged: (value) {
                  context.read<SearchTerm>().updateSearchTerm(term: value);
                },
                decoration: const InputDecoration(
                    hintText: "Search Courses",
                    hintStyle: TextStyle(fontSize: 20),
                    border: InputBorder.none),
              )
            : const Text("I-Learn"),
        leading: context.watch<Searching>().isSearching
            ? IconButton(
                onPressed: () {
                  setState(() {
                    context.read<SearchTerm>().updateSearchTerm(term: "");
                    context.read<Searching>().stopSearch();
                  });
                },
                icon: const Icon(Icons.arrow_back))
            : null,
        actions: [
          // Change the action button on the account page to a logout button
          screenIndex == 3
              ? IconButton(
                  onPressed: () {
                    supabase.auth.signOut();
                    preferences?.setString("currentUser", "");
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.logout),
                )
              // On the search page and the user is not searching, render a search icon button
              : (screenIndex == 1) && (!context.watch<Searching>().isSearching)
                  ? IconButton(
                      onPressed: () {
                        context.read<Searching>().startSearch();
                      },
                      icon: const Icon(Icons.search),
                    )
                  : const SizedBox()
        ],
        // Change the background colour of the app bar on the account page to match the profile component
        backgroundColor: screenIndex == 3
            ? const Color.fromRGBO(228, 252, 255, 1)
            : resolveAppHeaderColor());
  }

  Center pageBody() {
    return Center(
      child: pages.elementAt(screenIndex),
    );
  }

  // The Material Bottom Navigation Bar
  NavigationBar bottomNavBar() {
    return NavigationBar(
      selectedIndex: screenIndex,
      onDestinationSelected: (int index) {
        // Update the current screen when an icon is tapped
        setState(() {
          screenIndex = index;
        });
      },
      // Dynamically render the nav bar items from a util list. Increases code maintainability.
      destinations: pageDestinations.map((PageDestination page) {
        return NavigationDestination(
          label: page.label,
          icon: page.icon,
          selectedIcon: page.selectedIcon,
        );
      }).toList(),
    );
  }

  // The Material Side Navigation Drawer
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
        // Rendering the 4 main pages seen in the bottom nav bar. The active
        // state syncs between both the bottom nav bar and this side drawer
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
        // Seperate loop to render the nav items related to booking's which behave differently when tapped
        ...bookingDestinations.map((PageDestination destination) {
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
