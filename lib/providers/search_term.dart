import 'package:flutter/material.dart';

// Global state store to store the users search value
class SearchTerm with ChangeNotifier {
  String _searchTerm = "";

  // Method to get and watch the current search term
  String get searchTerm => _searchTerm;

  // Method to update the current search term, often called when the user is typing
  void updateSearchTerm({required String term}) {
    _searchTerm = term;
    notifyListeners();
  }
}
