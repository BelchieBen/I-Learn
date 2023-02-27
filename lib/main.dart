import 'package:booking_app/providers/search_term.dart';
import 'package:booking_app/providers/searching.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
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
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Searching(),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchTerm(),
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

class SplashScreen extends StatefulWidget {
  const SplashScreen({required Key key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
    );
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
                  MaterialPageRoute(builder: (context) => const AppScaffold()),
                ));
        },
      ),
    );
  }
}
