// riverpod/lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/app.dart';
import 'package:riverpod_app/core/config/env.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock screen to portrait mode only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  const flavorString = String.fromEnvironment('FLAVOR', defaultValue: 'dev');
  final flavor = AppFlavor.values.firstWhere((e) => e.name == flavorString);
  await Env.load(flavor);
  // await AppBootstrap.initialize();

  runApp(const ProviderScope(child: App()));
}
