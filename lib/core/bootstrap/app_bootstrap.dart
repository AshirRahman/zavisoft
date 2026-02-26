// riverpod/lib/core/bootstrap/app_bootstrap.dart
import 'package:riverpod_app/core/services/branch_service.dart';
import 'package:riverpod_app/core/services/firebase_service.dart';
import 'package:riverpod_app/core/services/supabase_service.dart';

class AppBootstrap {
  static Future<void> initialize() async {
    await SupabaseService.initialize();
    await FirebaseService.initialize();
    await BranchService.initialize();
  }
}
