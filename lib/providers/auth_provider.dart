import 'package:flutter/material.dart';
import '../models/user_model.dart';

/// -----------------------------------------------------------------------
/// AuthProvider
/// Manages login/logout state across the app.
///
/// IMPORTANT: The sign-in methods below are placeholders that simulate a
/// successful login so the rest of the app (Dashboard, Profile, etc.) is
/// fully navigable. Wire these up to real SDKs before release:
///   - Google      -> google_sign_in package + Firebase Auth
///   - Apple       -> sign_in_with_apple package + Firebase Auth
///   - Telegram    -> Telegram Login Widget / Bot API + your backend
///   - Facebook    -> flutter_facebook_auth package
///   - Email       -> Firebase Auth / your REST backend
///   - Phone       -> Firebase Auth phone verification (OTP)
/// -----------------------------------------------------------------------
class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  UserModel? _currentUser;

  bool get isLoggedIn => _isLoggedIn;
  UserModel? get currentUser => _currentUser;

  /// Generic "sign in" used by every login button on the Login screen.
  /// [method] is one of: google, apple, telegram, facebook, email, phone.
  Future<void> signInWith(String method, {String? nameHint}) async {
    // TODO: Replace with a real SDK call for [method].
    await Future.delayed(const Duration(milliseconds: 400)); // simulate network

    _currentUser = UserModel(
      name: nameHint ?? 'AlIqra Student',
      loginMethod: method,
      streakDays: 3,
      dailyGoalProgress: 0.45,
      achievements: ['First Lesson Completed'],
      certificates: [],
    );
    _isLoggedIn = true;
    notifyListeners();
  }

  void updateProfile(UserModel updated) {
    _currentUser = updated;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _currentUser = null;
    notifyListeners();
  }
}
