// riverpod/lib/core/bootstrap/dependency_injection.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/core/services/branch_service.dart';
import 'package:riverpod_app/core/services/firebase_service.dart';
import 'package:riverpod_app/core/services/local_auth_service.dart';
import 'package:riverpod_app/core/services/storage_service.dart';
import 'package:riverpod_app/core/services/supabase_service.dart';
import 'package:riverpod_app/core/session/session_manager.dart';

final supabaseServiceProvider =
    Provider<SupabaseService>((ref) => SupabaseService.instance);
final firebaseServiceProvider =
    Provider<FirebaseService>((ref) => FirebaseService.instance);
final branchServiceProvider =
    Provider<BranchService>((ref) => BranchService.instance);
final localAuthServiceProvider =
    Provider<LocalAuthService>((ref) => LocalAuthService());
final storageServiceProvider =
    Provider<StorageService>((ref) => StorageService());
final sessionManagerProvider =
    Provider<SessionManager>((ref) => SessionManager(ref));
