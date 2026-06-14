import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/artwork_tile.dart';
import '../../domain/entities/artist_summary.dart';

class ArtistChip extends StatelessWidget {
  const ArtistChip({super.key, required this.artist});

  final ArtistSummary artist;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 116,
      margin: const EdgeInsets.only(right: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ArtworkTile(
            tone: artist.artworkTone,
            label: artist.name,
            size: 88,
            borderRadius: 44,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            artist.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            '${artist.albumCount} album  |  ${artist.songCount} songs',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}
