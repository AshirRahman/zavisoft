// riverpod/lib/core/services/branch_service.dart
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:riverpod_app/core/config/env.dart';

class BranchService {
  static BranchService? _instance;
  static BranchService get instance => _instance ??= BranchService._();

  BranchService._();

  static Future<void> initialize() async {
    FlutterBranchSdk.initSession();
    FlutterBranchSdk.setIdentity(Env.branchKey);
  }
}
