import 'package:flutter/material.dart';
import 'src/components/scaffold/app_scaffold.dart';

void main() {
  runApp(
    MaterialApp(
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
      home: const AppScaffold(),
    ),
  );
}
