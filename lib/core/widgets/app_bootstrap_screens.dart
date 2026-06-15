import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_icons.dart';
import '../theme/app_spacing.dart';

class AppBootstrapLoadingScreen extends StatelessWidget {
  const AppBootstrapLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(AppIcons.logo, color: AppColors.accent, size: 40),
              const SizedBox(height: AppSpacing.md),
              Text('Nexo', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: AppSpacing.sm),
              const SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(color: AppColors.accent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppBootstrapErrorScreen extends StatelessWidget {
  const AppBootstrapErrorScreen({super.key, required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.error_outline_rounded,
                  color: AppColors.accent,
                  size: 40,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'Bootstrap failed',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  '$error',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
