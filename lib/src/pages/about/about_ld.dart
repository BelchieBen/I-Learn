import 'package:flutter/material.dart';

import '../../util/resolve_header_color.dart';

class AboutLD extends StatefulWidget {
  const AboutLD({super.key});

  @override
  State<AboutLD> createState() => _AboutLDState();
}

class _AboutLDState extends State<AboutLD> {
  AppBar appHeader() {
    return AppBar(
        title: const Text("About L&D"),
        backgroundColor: resolveAppHeaderColor());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appHeader(),
      body: const Center(
        child: Text("About L&D"),
      ),
    );
  }
}
