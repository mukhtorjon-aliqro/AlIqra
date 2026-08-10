import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../widgets/module_card.dart';
import 'placeholder_module_screen.dart';

/// -----------------------------------------------------------------------
/// QuranCenterScreen
/// SRS section 4 -> Quran Center: Quran, Qiraat, Tajweed, Memorization,
/// Tafsir. Each sub-module is currently a placeholder screen; wire real
/// content/audio/AI features in later.
/// -----------------------------------------------------------------------
class QuranCenterScreen extends StatelessWidget {
  const QuranCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    final modules = [
      (Icons.menu_book_rounded, t.t('quran')),
      (Icons.record_voice_over, t.t('qiraat')),
      (Icons.graphic_eq, t.t('tajweed')),
      (Icons.psychology_alt, t.t('memorization')),
      (Icons.chrome_reader_mode, t.t('tafsir')),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(t.t('quranCenter'))),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: modules.length,
        itemBuilder: (context, index) {
          final (icon, title) = modules[index];
          return ModuleCard(
            icon: icon,
            title: title,
            subtitle: t.t('comingSoon'),
            onTap: () => _openPlaceholder(context, title),
          );
        },
      ),
    );
  }

  void _openPlaceholder(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PlaceholderModuleScreen(title: title)),
    );
  }
}
