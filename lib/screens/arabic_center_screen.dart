import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../widgets/module_card.dart';
import 'placeholder_module_screen.dart';

/// -----------------------------------------------------------------------
/// ArabicCenterScreen
/// SRS section 4 -> Arabic Center: Bayna Yadayk, Madinah Books, Nahw,
/// Sarf, Dictionary, Conversation.
/// -----------------------------------------------------------------------
class ArabicCenterScreen extends StatelessWidget {
  const ArabicCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    final modules = [
      (Icons.book_outlined, t.t('baynaYadayk')),
      (Icons.library_books_outlined, t.t('madinahBooks')),
      (Icons.rule, t.t('nahw')),
      (Icons.spellcheck, t.t('sarf')),
      (Icons.translate, t.t('dictionary')),
      (Icons.chat_bubble_outline, t.t('conversation')),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(t.t('arabicCenter'))),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: modules.length,
        itemBuilder: (context, index) {
          final (icon, title) = modules[index];
          return ModuleCard(
            icon: icon,
            title: title,
            subtitle: t.t('comingSoon'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => PlaceholderModuleScreen(title: title)),
            ),
          );
        },
      ),
    );
  }
}
