import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'l10n/locale_provider.dart';
import 'providers/auth_provider.dart';

/// -----------------------------------------------------------------------
/// AlIqra — main.dart
/// App entry point. Responsibilities:
///   1. Ensure Flutter bindings are ready before doing async work.
///   2. Create the app-wide LocaleProvider and load any previously saved
///      language (defaults to English per spec if none saved yet).
///   3. Register all app-wide providers (Locale + Auth) with
///      MultiProvider so every screen can read/watch them.
///   4. Launch the root AlIqraApp widget (see app.dart).
/// -----------------------------------------------------------------------
Future<void> main() async {
  // Required before calling async code (SharedPreferences) pre-runApp.
  WidgetsFlutterBinding.ensureInitialized();

  // Load the user's previously chosen language, if any.
  final localeProvider = LocaleProvider();
  await localeProvider.loadSavedLocale();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LocaleProvider>.value(value: localeProvider),
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
      ],
      child: const AlIqraApp(),
    ),
  );
}
