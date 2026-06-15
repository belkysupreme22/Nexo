import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/bootstrap/app_bootstrap.dart';
import '../../../../core/config/app_environment.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bootstrapState = ref.watch(appBootstrapProvider).valueOrNull;
    final backendMode =
        bootstrapState?.backendMode == NexoBackendMode.supabaseConnected
        ? 'Supabase connected'
        : 'Local only';
    final flavor = bootstrapState?.environment.appFlavor ?? 'development';

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Settings', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: AppSpacing.lg),
            _SettingCard(
              title: 'Phase 0 foundation',
              description:
                  'Theme tokens, routing, Riverpod state, and clean feature boundaries are in place.',
            ),
            const SizedBox(height: AppSpacing.md),
            _SettingCard(
              title: 'Runtime environment',
              description:
                  'Flavor: $flavor. Backend mode: $backendMode. This is now driven by bootstrap configuration instead of screen-level assumptions.',
            ),
            const SizedBox(height: AppSpacing.md),
            _SettingCard(
              title: 'Playback platform bridge',
              description:
                  'Flutter owns the experience. Media3, ExoPlayer, notifications, and background playback stay on the Kotlin side next.',
            ),
            const SizedBox(height: AppSpacing.md),
            _SettingCard(
              title: 'Cloud sync path',
              description:
                  'Drift and Supabase are staged at the dependency level so the local-first data layer can land in the next phase work.',
            ),
            if (bootstrapState != null &&
                bootstrapState.warnings.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.md),
              for (final warning in bootstrapState.warnings)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: _SettingCard(
                    title: 'Bootstrap note',
                    description: warning,
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SettingCard extends StatelessWidget {
  const _SettingCard({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
