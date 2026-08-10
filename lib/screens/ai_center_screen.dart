import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../widgets/module_card.dart';
import 'placeholder_module_screen.dart';

/// -----------------------------------------------------------------------
/// AICenterScreen
/// SRS section 4 -> AI Center: AI Teacher, AI Qari, AI Conversation
/// Partner, AI Mentor. These map onto the AI Features in SRS section 5
/// (Q&A, lesson explanation, Qiraat evaluation, pronunciation checking,
/// Arabic conversation, personalized study plans, auto test generation)
/// once real model integrations are added.
/// -----------------------------------------------------------------------
class AICenterScreen extends StatelessWidget {
  const AICenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    final modules = [
      (Icons.school_outlined, t.t('aiTeacher')),
      (Icons.record_voice_over_outlined, t.t('aiQari')),
      (Icons.forum_outlined, t.t('aiConversationPartner')),
      (Icons.support_agent, t.t('aiMentor')),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(t.t('aiCenter'))),
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
