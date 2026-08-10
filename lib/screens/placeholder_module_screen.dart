import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

/// -----------------------------------------------------------------------
/// PlaceholderModuleScreen
/// Generic "coming soon" detail screen shared by every sub-module across
/// Quran Center / Arabic Center / AI Center until real lesson content,
/// AI integrations, etc. are built out.
/// -----------------------------------------------------------------------
class PlaceholderModuleScreen extends StatelessWidget {
  final String title;
  const PlaceholderModuleScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.construction, size: 48, color: Colors.grey),
            const SizedBox(height: 12),
            Text(t.t('comingSoon'), style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
      ),
    );
  }
}
