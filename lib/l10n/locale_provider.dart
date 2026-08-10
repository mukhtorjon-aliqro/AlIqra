import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_localizations.dart';

/// -----------------------------------------------------------------------
/// LocaleProvider
/// Holds the currently active app Locale, persists the user's choice to
/// device storage, and notifies listeners so the whole app rebuilds with
/// the new language instantly (no restart needed).
/// -----------------------------------------------------------------------
class LocaleProvider extends ChangeNotifier {
  static const _prefsKey = 'aliqra_locale_code';

  // Default language required by spec: English
  Locale _locale = const Locale('en');
  Locale get locale => _locale;

  /// Load any previously-saved language when the app starts.
  Future<void> loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCode = prefs.getString(_prefsKey);
    if (savedCode != null) {
      _locale = _localeFromCode(savedCode);
      notifyListeners();
    }
  }

  /// Change language (called from the language picker) and persist it.
  Future<void> setLocale(String code) async {
    _locale = _localeFromCode(code);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, code);
  }

  Locale _localeFromCode(String code) {
    if (code == 'uz_latn') {
      return const Locale.fromSubtags(languageCode: 'uz', scriptCode: 'Latn');
    }
    if (code == 'uz_cyrl') {
      return const Locale.fromSubtags(languageCode: 'uz', scriptCode: 'Cyrl');
    }
    return Locale(code);
  }

  /// Current short code, e.g. for highlighting the active item in the list
  String get currentCode => AppLocalizations.codeFor(_locale);
}
