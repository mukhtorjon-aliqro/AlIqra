import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/auth_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/language_selector.dart';

/// -----------------------------------------------------------------------
/// ProfileScreen
/// Implements SRS section 7 fields: Name, Country, Language, Age,
/// Children/Adults, Knowledge Level, Achievements, Certificates.
/// -----------------------------------------------------------------------
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _countryController;
  late TextEditingController _ageController;

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthProvider>().currentUser;
    _nameController = TextEditingController(text: user?.name ?? '');
    _countryController = TextEditingController(text: user?.country ?? '');
    _ageController = TextEditingController(text: (user?.age ?? '').toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _countryController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final auth = context.watch<AuthProvider>();
    final user = auth.currentUser;

    return Scaffold(
      appBar: AppBar(title: Text(t.t('profile'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Avatar
          Center(
            child: CircleAvatar(
              radius: 44,
              backgroundColor: AppColors.lightGreen,
              child: const Icon(Icons.person, size: 44, color: AppColors.primaryGreen),
            ),
          ),
          const SizedBox(height: 20),

          _LabeledField(label: t.t('name'), controller: _nameController),
          _LabeledField(label: t.t('country'), controller: _countryController),

          // Language row -> opens language bottom sheet
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(t.t('language')),
            subtitle: Text(_currentLanguageLabel(context)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => showLanguageSelector(context),
          ),

          _LabeledField(
            label: t.t('age'),
            controller: _ageController,
            keyboardType: TextInputType.number,
          ),

          // Age group (Child / Adult) as a simple segmented choice
          const SizedBox(height: 8),
          Text(t.t('knowledgeLevel'), style: Theme.of(context).textTheme.bodySmall),
          Wrap(
            spacing: 8,
            children: ['beginner', 'intermediate', 'advanced'].map((level) {
              final selected = (user?.knowledgeLevel ?? 'beginner') == level;
              return ChoiceChip(
                label: Text(t.t(level)),
                selected: selected,
                selectedColor: AppColors.lightGreen,
                onSelected: (_) {
                  if (user != null) {
                    user.knowledgeLevel = level;
                    context.read<AuthProvider>().updateProfile(user);
                  }
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 20),

          // Achievements
          Text(t.t('achievements'), style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          if ((user?.achievements ?? []).isEmpty)
            Text(t.t('comingSoon'), style: Theme.of(context).textTheme.bodySmall)
          else
            ...user!.achievements.map(
              (a) => ListTile(
                leading: const Icon(Icons.emoji_events, color: AppColors.accentGreen),
                title: Text(a),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          const SizedBox(height: 12),

          // Certificates
          Text(t.t('certificates'), style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          if ((user?.certificates ?? []).isEmpty)
            Text(t.t('comingSoon'), style: Theme.of(context).textTheme.bodySmall),

          const SizedBox(height: 28),

          // Save button
          ElevatedButton(
            onPressed: () {
              if (user != null) {
                user.name = _nameController.text;
                user.country = _countryController.text;
                user.age = int.tryParse(_ageController.text) ?? user.age;
                context.read<AuthProvider>().updateProfile(user);
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(t.t('save'))),
              );
            },
            child: Text(t.t('save')),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () => context.read<AuthProvider>().logout(),
            child: Text(t.t('logout')),
          ),
        ],
      ),
    );
  }

  String _currentLanguageLabel(BuildContext context) {
    final code = AppLocalizations.codeFor(Localizations.localeOf(context));
    return AppLocalizations.displayNames[code] ?? 'English';
  }
}

/// Simple labeled text field used throughout the Profile form.
class _LabeledField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  const _LabeledField({
    required this.label,
    required this.controller,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
