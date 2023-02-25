import 'package:flutter/material.dart';

class SearchTerm with ChangeNotifier {
  String _searchTerm = "";
  String get searchTerm => _searchTerm;

  void updateSearchTerm({required String term}) {
    _searchTerm = term;
    notifyListeners();
  }
}
