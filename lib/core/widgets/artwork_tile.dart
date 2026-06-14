import 'package:flutter/material.dart';

import '../media/media_item.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';

class ArtworkTile extends StatelessWidget {
  const ArtworkTile({
    super.key,
    required this.tone,
    required this.label,
    this.size = 64,
    this.borderRadius = AppRadius.md,
  });

  final ArtworkTone tone;
  final String label;
  final double size;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final colors = _resolveTone(tone);
    final extent = size.isFinite ? size : null;

    return Container(
      width: extent,
      height: extent,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
      ),
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          label.toUpperCase(),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  List<Color> _resolveTone(ArtworkTone tone) {
    switch (tone) {
      case ArtworkTone.ember:
        return const [AppColors.artEmberStart, AppColors.artEmberEnd];
      case ArtworkTone.rose:
        return const [AppColors.artRoseStart, AppColors.artRoseEnd];
      case ArtworkTone.ocean:
        return const [AppColors.artOceanStart, AppColors.artOceanEnd];
      case ArtworkTone.pulse:
        return const [AppColors.artPulseStart, AppColors.artPulseEnd];
      case ArtworkTone.forest:
        return const [AppColors.artForestStart, AppColors.artForestEnd];
    }
  }
}
