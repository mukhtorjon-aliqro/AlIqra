import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/auth_provider.dart';
import '../theme/app_theme.dart';

/// -----------------------------------------------------------------------
/// DashboardScreen
/// Home tab, implements SRS section 8:
///   - Today's Lesson
///   - Streak
///   - Daily Goal
///   - AI Recommendations
///   - Next Task
/// -----------------------------------------------------------------------
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final user = context.watch<AuthProvider>().currentUser;

    return Scaffold(
      appBar: AppBar(title: Text(t.t('dashboard'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Greeting
          Text(
            '${t.t('welcomeBack')}, ${user?.name ?? ''} 👋',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),

          // Streak + Daily goal row
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  icon: Icons.local_fire_department,
                  label: t.t('streak'),
                  value: '${user?.streakDays ?? 0} ${t.t('days')}',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _GoalCard(
                  label: t.t('dailyGoal'),
                  progress: user?.dailyGoalProgress ?? 0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Today's Lesson
          _SectionCard(
            icon: Icons.menu_book_rounded,
            title: t.t('todaysLesson'),
            body: 'Surah Al-Fatiha — Tajweed basics', // sample placeholder content
          ),

          // AI Recommendations
          _SectionCard(
            icon: Icons.auto_awesome,
            title: t.t('aiRecommendations'),
            body: 'Practice Qiraat pronunciation for 10 minutes today.',
          ),

          // Next Task
          _SectionCard(
            icon: Icons.task_alt,
            title: t.t('nextTask'),
            body: 'Complete Lesson 3 in Madinah Book 1.',
          ),
        ],
      ),
    );
  }
}

/// Small stat card (used for Streak)
class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _StatCard({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.accentGreen),
            const SizedBox(height: 8),
            Text(value, style: Theme.of(context).textTheme.titleLarge),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

/// Daily goal progress card
class _GoalCard extends StatelessWidget {
  final String label;
  final double progress;
  const _GoalCard({required this.label, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${(progress * 100).round()}%',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6,
                backgroundColor: AppColors.lightGreen,
                color: AppColors.primaryGreen,
              ),
            ),
            const SizedBox(height: 4),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

/// Generic content section card (Today's Lesson / AI Recommendation / Next Task)
class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  const _SectionCard({required this.icon, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.lightGreen,
          child: Icon(icon, color: AppColors.primaryGreen),
        ),
        title: Text(title, style: Theme.of(context).textTheme.titleLarge),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(body),
        ),
      ),
    );
  }
}
