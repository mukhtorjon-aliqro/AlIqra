import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'l10n/app_localizations.dart';
import 'l10n/locale_provider.dart';
import 'providers/auth_provider.dart';
import 'screens/login_screen.dart';
import 'screens/main_screen.dart';
import 'theme/app_theme.dart';

/// -----------------------------------------------------------------------
/// AlIqraApp
/// Root widget of the application:
///   - Reads the active Locale from LocaleProvider and rebuilds the whole
///     app when the user changes language (no restart required).
///   - Applies the shared green/white AppTheme.
///   - Decides whether to show LoginScreen or MainScreen based on
///     AuthProvider.isLoggedIn.
/// -----------------------------------------------------------------------
class AlIqraApp extends StatelessWidget {
  const AlIqraApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = context.watch<LocaleProvider>();
    final isLoggedIn = context.watch<AuthProvider>().isLoggedIn;

    return MaterialApp(
      title: 'AlIqra',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,

      // ---- Localization wiring (SRS section 3: 15 languages) ----
      locale: localeProvider.locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (deviceLocale, supported) {
        // Fall back to English if the device language isn't one of our 15.
        if (deviceLocale == null) return const Locale('en');
        for (final locale in supported) {
          if (locale.languageCode == deviceLocale.languageCode) {
            return locale;
          }
        }
        return const Locale('en');
      },

      // Automatically mirrors layout direction for Arabic (RTL).
      builder: (context, child) {
        return Directionality(
          textDirection: AppLocalizations.directionFor(localeProvider.locale),
          child: child!,
        );
      },

      // ---- Simple auth-gated routing ----
      home: isLoggedIn ? const MainScreen() : const LoginScreen(),
    );
  }
}
