import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// -----------------------------------------------------------------------
/// CustomButton
/// A reusable outlined button with a leading icon, used for every login
/// option (Google / Apple / Telegram / Facebook / Email / Phone) so the
/// Login screen stays clean and DRY.
/// -----------------------------------------------------------------------
class CustomButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color? iconColor;

  const CustomButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: iconColor ?? AppColors.primaryGreen),
        label: Align(
          alignment: Alignment.center,
          child: Text(label),
        ),
      ),
    );
  }
}
