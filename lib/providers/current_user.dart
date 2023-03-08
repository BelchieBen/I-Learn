import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

// Global state store for the current logged in user
class CurrentUser with ChangeNotifier {
  supabase.User? _user;

  // Method to retrieve and watch the currenr user
  supabase.User? get user => _user;

  // Method to set the current user
  void setUser(supabase.User user) {
    _user = user;
    notifyListeners();
  }
}
