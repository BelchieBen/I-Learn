import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

class CurrentUser with ChangeNotifier {
  supabase.User? _user;
  supabase.User? get user => _user;

  void setUser(supabase.User user) {
    _user = user;
    notifyListeners();
  }
}
