import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/artwork_tile.dart';
import '../providers/player_providers.dart';

class NowPlayingScreen extends ConsumerWidget {
  const NowPlayingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(playerControllerProvider);
    final controller = ref.read(playerControllerProvider.notifier);
    final song = playerState.currentSong;

    if (song == null) {
      return const Scaffold(body: Center(child: Text('Queue is empty.')));
    }

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ArtworkTile(
                  tone: song.artworkTone,
                  label: song.title,
                  size: double.infinity,
                  borderRadius: AppRadius.lg,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                song.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                song.subtitle,
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: AppSpacing.lg),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: AppColors.accent,
                  inactiveTrackColor: AppColors.surfaceMuted,
                  thumbColor: AppColors.accentSoft,
                  overlayColor: const Color(0x1FFF972F),
                ),
                child: Slider(
                  value: playerState.progress,
                  onChanged: controller.seek,
                ),
              ),
              Row(
                children: [
                  Text(
                    '01:35',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
                  ),
                  const Spacer(),
                  Text(
                    song.durationLabel,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(AppIcons.shuffle, color: AppColors.textMuted),
                  IconButton(
                    onPressed: controller.playPrevious,
                    iconSize: 36,
                    icon: const Icon(
                      AppIcons.previous,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColors.accentDeep,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: controller.togglePlayback,
                      iconSize: 42,
                      icon: Icon(
                        playerState.isPlaying ? AppIcons.pause : AppIcons.play,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: controller.playNext,
                    iconSize: 36,
                    icon: const Icon(
                      AppIcons.next,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Icon(AppIcons.repeat, color: AppColors.textMuted),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lyrics',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      song.lyricsPreview,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
