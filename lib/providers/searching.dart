import 'package:flutter/material.dart';

class Searching with ChangeNotifier {
  bool _isSearching = false;
  bool get isSearching => _isSearching;

  void startSearch() {
    _isSearching = true;
    notifyListeners();
  }

  void stopSearch() {
    _isSearching = false;
    notifyListeners();
  }
}
