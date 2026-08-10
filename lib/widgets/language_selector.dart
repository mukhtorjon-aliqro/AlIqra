import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../l10n/locale_provider.dart';
import '../theme/app_theme.dart';

/// -----------------------------------------------------------------------
/// LanguageSelector
/// A bottom-sheet list of all 15 supported languages. Call
/// `showLanguageSelector(context)` from anywhere (Login screen, Profile
/// screen) to let the user change the app language.
/// -----------------------------------------------------------------------
void showLanguageSelector(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) => const _LanguageSelectorSheet(),
  );
}

class _LanguageSelectorSheet extends StatelessWidget {
  const _LanguageSelectorSheet();

  @override
  Widget build(BuildContext context) {
    final localeProvider = context.watch<LocaleProvider>();
    final entries = AppLocalizations.displayNames.entries.toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context).t('selectLanguage'),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: entries.length,
                itemBuilder: (context, index) {
                  final code = entries[index].key;
                  final label = entries[index].value;
                  final isSelected = localeProvider.currentCode == code;
                  return ListTile(
                    title: Text(label),
                    trailing: isSelected
                        ? const Icon(Icons.check_circle, color: AppColors.primaryGreen)
                        : null,
                    onTap: () {
                      context.read<LocaleProvider>().setLocale(code);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
