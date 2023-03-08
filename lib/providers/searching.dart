import 'package:flutter/material.dart';

// Global state store for the searching flag, helps the app identify when the user is searching
class Searching with ChangeNotifier {
  bool _isSearching = false;

  // Method to get the current search state
  bool get isSearching => _isSearching;

  // Method to start a search
  void startSearch() {
    _isSearching = true;
    notifyListeners();
  }

  // Method to stop a search
  void stopSearch() {
    _isSearching = false;
    notifyListeners();
  }
}
