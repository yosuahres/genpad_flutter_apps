// lib/main.dart
import 'package:flutter/material.dart';
import 'package:application_genpad_local/core/extensions/hive_extensions.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:application_genpad_local/core/app/app.dart';
import 'package:application_genpad_local/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeSupabase(); 
  await _initializeHive();
  configureDependencyInjection();

  runApp(
    const FlutterSupabaseStarterApp(),
  );
}

Future<void> initializeSupabase() async {
  await Supabase.initialize(
    url: 'https://dzdnykddcgowxviipvxe.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR6ZG55a2RkY2dvd3h2aWlwdnhlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg2NDU2NjIsImV4cCI6MjA4NDIyMTY2Mn0.QAwneMWa_8SyLWNHgzbp8l1vJzOusrADq4vQDph_Wjo',
  );
}

Future<void> _initializeHive() async {
  await Hive.initFlutter();
  await Hive.openThemeModeBox();
}