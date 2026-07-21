import 'package:flutter/material.dart';

class EmptyStateView extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final VoidCallback? onAction;
  final String? actionLabel;

  const EmptyStateView({
    super.key,
    required this.title,
    required this.message,
    this.icon = Icons.search_off_rounded,
    this.onAction,
    this.actionLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: (isDark ? const Color(0xFF334155) : Colors.grey.shade200).withAlpha(150),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 50,
                color: isDark ? const Color(0xFF94A3B8) : Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isDark ? const Color(0xFF94A3B8) : Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            if (onAction != null && actionLabel != null) ...[
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.clear_rounded, size: 18),
                label: Text(actionLabel!),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF635BFF),
                  side: const BorderSide(color: Color(0xFF635BFF)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
