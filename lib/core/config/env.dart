// lib/core/config/env.dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum AppFlavor { dev, staging, prod }

class Env {
  static late AppFlavor flavor;

  static Future<void> load(AppFlavor appFlavor) async {
    flavor = appFlavor;

    switch (appFlavor) {
      case AppFlavor.dev:
        await dotenv.load(fileName: '.env.dev');
        break;

      case AppFlavor.staging:
        await dotenv.load(fileName: '.env.staging');
        break;

      case AppFlavor.prod:
        await dotenv.load(fileName: '.env.prod');
        break;
    }
  }

  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';
  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';
  static String get branchKey => dotenv.env['BRANCH_IO_KEY'] ?? '';
  static String get apiBaseUrl =>
      dotenv.env['API_BASE_URL'] ?? 'https://fakestoreapi.com';
}
