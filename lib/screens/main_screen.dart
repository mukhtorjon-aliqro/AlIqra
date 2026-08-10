import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'ai_center_screen.dart';
import 'arabic_center_screen.dart';
import 'dashboard_screen.dart';
import 'profile_screen.dart';
import 'quran_center_screen.dart';

/// -----------------------------------------------------------------------
/// MainScreen
/// Shown after a successful login. Hosts the bottom navigation bar with
/// the 4 primary destinations: Dashboard, Quran Center, Arabic Center,
/// AI Center, plus Profile. Uses IndexedStack so each tab keeps its own
/// scroll position / state when switching.
/// -----------------------------------------------------------------------
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Order must match the icons/labels list below.
  static const _screens = [
    DashboardScreen(),
    QuranCenterScreen(),
    ArabicCenterScreen(),
    AICenterScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_rounded),
            label: t.t('dashboard'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.menu_book_rounded),
            label: t.t('quranCenter'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.abc),
            label: t.t('arabicCenter'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.smart_toy_outlined),
            label: t.t('aiCenter'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            label: t.t('profile'),
          ),
        ],
      ),
    );
  }
}
