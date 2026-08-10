import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/auth_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/language_selector.dart';

/// -----------------------------------------------------------------------
/// LoginScreen
/// First screen the user sees. Shows the AlIqra logo/tagline, a language
/// switcher (top-right globe icon, per SRS section 3), and the 6 login
/// options required by SRS section 6.
/// -----------------------------------------------------------------------
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            // Language picker button (top-right)
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: const Icon(Icons.language, color: AppColors.primaryGreen),
                  tooltip: t.t('selectLanguage'),
                  onPressed: () => showLanguageSelector(context),
                ),
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // App logo bubble (simple icon placeholder — replace with
                  // real logo asset in assets/images/logo.png)
                  Container(
                    width: 96,
                    height: 96,
                    decoration: const BoxDecoration(
                      color: AppColors.lightGreen,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.menu_book_rounded,
                        size: 48, color: AppColors.primaryGreen),
                  ),
                  const SizedBox(height: 20),
                  Text(t.t('appName'), style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 8),
                  Text(
                    t.t('tagline'),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 36),

                  // ---- Login options (SRS section 6) ----
                  CustomButton(
                    icon: Icons.g_mobiledata,
                    label: t.t('continueWithGoogle'),
                    onPressed: auth.isLoggedIn
                        ? () {}
                        : () => _handleLogin(context, 'google'),
                  ),
                  CustomButton(
                    icon: Icons.apple,
                    label: t.t('continueWithApple'),
                    onPressed: () => _handleLogin(context, 'apple'),
                  ),
                  CustomButton(
                    icon: Icons.send,
                    label: t.t('continueWithTelegram'),
                    onPressed: () => _handleLogin(context, 'telegram'),
                  ),
                  CustomButton(
                    icon: Icons.facebook,
                    label: t.t('continueWithFacebook'),
                    onPressed: () => _handleLogin(context, 'facebook'),
                  ),
                  CustomButton(
                    icon: Icons.email_outlined,
                    label: t.t('continueWithEmail'),
                    onPressed: () => _handleLogin(context, 'email'),
                  ),
                  CustomButton(
                    icon: Icons.phone_outlined,
                    label: t.t('continueWithPhone'),
                    onPressed: () => _handleLogin(context, 'phone'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Triggers the (currently mocked) sign-in flow. MainScreen listens to
  /// AuthProvider and automatically swaps to the Dashboard on success —
  /// see main.dart / app.dart for the routing logic.
  Future<void> _handleLogin(BuildContext context, String method) async {
    await context.read<AuthProvider>().signInWith(method);
  }
}
