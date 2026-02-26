// riverpod/lib/core/session/session_manager.dart
import 'package:flutter/material.dart';
// import 'package:riverpod/core/services/supabase_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// Extend ChangeNotifier!
class SessionManager extends ChangeNotifier {
  final Ref ref;

  SessionManager(this.ref) {
    // Listen to Supabase auth changes
    // SupabaseService.instance.client.auth.onAuthStateChange.listen((data) {
    //   // Notify the router whenever Auth state changes (login/logout)
    //   notifyListeners();
    // });
  }

  bool get isLoggedIn => false;
  // SupabaseService.instance.client.auth.currentUser != null;
}
