import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/artwork_tile.dart';
import '../../domain/entities/song.dart';

class SongListTile extends StatelessWidget {
  const SongListTile({super.key, required this.song, required this.onTap});

  final Song song;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppSpacing.md),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        child: Row(
          children: [
            ArtworkTile(tone: song.artworkTone, label: song.title, size: 56),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    '${song.artist}  |  ${song.durationLabel}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Icon(
              song.isFavorite ? AppIcons.favorite : AppIcons.play,
              color: song.isFavorite ? AppColors.accent : AppColors.textMuted,
              size: 20,
            ),
            const SizedBox(width: AppSpacing.xs),
            const Icon(AppIcons.more, color: AppColors.textMuted, size: 20),
          ],
        ),
      ),
    );
  }
}
