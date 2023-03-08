import 'package:flutter/material.dart';

// Helper function to change the app header colour when scrolled. This is used to match the Helix colour scheme
MaterialStateColor resolveAppHeaderColor() {
  return MaterialStateColor.resolveWith((Set<MaterialState> states) {
    return states.contains(MaterialState.scrolledUnder)
        ? const Color.fromRGBO(244, 245, 246, 1)
        : const Color.fromRGBO(255, 251, 255, 1);
  });
}
