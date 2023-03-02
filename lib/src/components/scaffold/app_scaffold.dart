import 'package:booking_app/providers/search_term.dart';
import 'package:booking_app/providers/searching.dart';
import 'package:booking_app/src/pages/auth/register.dart';
import 'package:booking_app/src/util/page_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../util/resolve_header_color.dart';

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

  void handleScreenChanged(int selectedScreen) {
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
          screenIndex == 3
              ? IconButton(
                  onPressed: () {
                    supabase.auth.signOut();
                    preferences?.setString("currentUser", "");
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.logout),
                )
              : (screenIndex == 1) && (!context.watch<Searching>().isSearching)
                  ? IconButton(
                      onPressed: () {
                        context.read<Searching>().startSearch();
                      },
                      icon: const Icon(Icons.search),
                    )
                  : const SizedBox()
        ],
        backgroundColor: screenIndex == 3
            ? const Color.fromRGBO(228, 252, 255, 1)
            : resolveAppHeaderColor());
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
