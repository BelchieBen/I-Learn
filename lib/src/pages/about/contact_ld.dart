import 'package:flutter/material.dart';

import '../../util/resolve_header_color.dart';

class ContactLD extends StatefulWidget {
  const ContactLD({super.key});

  @override
  State<ContactLD> createState() => _AboutLDState();
}

class _AboutLDState extends State<ContactLD> {
  AppBar appHeader() {
    return AppBar(
      title: const Text("Contact L&D"),
      backgroundColor: resolveAppHeaderColor(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appHeader(),
      body: const Center(
        child: Text("Contact L&D"),
      ),
    );
  }
}
