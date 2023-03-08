import 'package:booking_app/providers/current_user.dart';
import 'package:booking_app/providers/search_term.dart';
import 'package:booking_app/providers/searching.dart';
import 'package:booking_app/src/pages/auth/login.dart';
import 'package:booking_app/src/pages/auth/register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'src/components/scaffold/app_scaffold.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(
    // Setting up my my global state store
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Searching(),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchTerm(),
        ),
        ChangeNotifierProvider(
          create: (_) => CurrentUser(),
        ),
      ],
      child: MaterialApp(
        title: 'NavigationDrawer Example',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'Gilroy Medium',
            useMaterial3: true,
            primaryColor: const Color.fromRGBO(92, 199, 208, 1),
            navigationBarTheme: const NavigationBarThemeData(
              indicatorColor: Color.fromRGBO(92, 199, 208, 1),
              backgroundColor: Color.fromRGBO(244, 245, 246, 1),
            ),
            navigationDrawerTheme: const NavigationDrawerThemeData(
              indicatorColor: Color.fromRGBO(152, 229, 236, 1),
              backgroundColor: Color.fromRGBO(244, 245, 246, 1),
            )),
        home: const SplashScreen(key: Key("")),
      ),
    ),
  );
}

// A widget to display an animated splash screen after the native splash screen and before the app homepage
class SplashScreen extends StatefulWidget {
  const SplashScreen({required Key key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  bool userAuthenticated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
    );
    _checkCurrentUser();
  }

  // Method to check if a user is authenticated, returns true or false,
  // it checks the device preferences and the supabase session, if either of
  // these are valid the function returns true
  _checkCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    SupabaseClient supabase = Supabase.instance.client;
    String? currentUser = prefs.getString("currentUser");
    setState(() {
      userAuthenticated =
          ((currentUser != null ? currentUser.isNotEmpty : false) ||
                  supabase.auth.currentUser != null
              ? true
              : false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Lottie.network(
        'https://bensreacttest.s3.us-west-2.amazonaws.com/splash+screen.json',
        // 'assets/splash-screen.json',
        controller: _controller,
        frameRate: FrameRate.max,
        height: MediaQuery.of(context).size.height * 1,
        animate: true,
        onLoaded: (composition) {
          _controller
            ..duration = composition.duration
            ..forward().whenComplete(() => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => userAuthenticated
                          ? const AppScaffold()
                          : const LoginPage()),
                ));
        },
      ),
    );
  }
}
