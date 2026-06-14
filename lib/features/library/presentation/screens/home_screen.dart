import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/section_header.dart';
import '../providers/library_providers.dart';
import '../widgets/album_showcase_card.dart';
import '../widgets/artist_chip.dart';
import '../widgets/song_list_tile.dart';
import '../../../player/presentation/providers/player_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overviewAsync = ref.watch(libraryOverviewProvider);

    return overviewAsync.when(
      data: (overview) {
        final heroSong = overview.songs.first;

        return CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: true,
              backgroundColor: const Color(0xF0171921),
              title: Row(
                children: [
                  const Icon(AppIcons.logo, color: AppColors.accent, size: 22),
                  const SizedBox(width: AppSpacing.xs),
                  Text('Nexo', style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: AppSpacing.md),
                  child: Icon(AppIcons.search, color: AppColors.textMuted),
                ),
              ],
            ),
            SliverPadding(
              padding: const EdgeInsets.all(AppSpacing.md),
              sliver: SliverList(
                delegate: SliverChildListDelegate.fixed([
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      boxShadow: [...AppShadows.card, ...AppShadows.glow],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recently lit up',
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(color: AppColors.accent),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          heroSong.title,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          heroSong.subtitle,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  ref
                                      .read(playerControllerProvider.notifier)
                                      .playSong(heroSong);
                                  context.push('/player');
                                },
                                icon: const Icon(AppIcons.play),
                                label: const Text('Play now'),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.surfaceMuted,
                                borderRadius: BorderRadius.circular(
                                  AppRadius.pill,
                                ),
                              ),
                              child: IconButton(
                                onPressed: () => context.go('/library'),
                                icon: const Icon(
                                  AppIcons.library,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  const SectionHeader(
                    title: 'Recently Played',
                    actionLabel: 'See all',
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SizedBox(
                    height: 270,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: overview.albums.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: AppSpacing.md),
                      itemBuilder: (context, index) {
                        return AlbumShowcaseCard(album: overview.albums[index]);
                      },
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  const SectionHeader(title: 'Artists', actionLabel: 'See all'),
                  const SizedBox(height: AppSpacing.md),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: overview.artists.length,
                      itemBuilder: (context, index) {
                        return ArtistChip(artist: overview.artists[index]);
                      },
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  const SectionHeader(
                    title: 'Most Played',
                    actionLabel: 'Queue',
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  for (final song in overview.songs.take(5))
                    SongListTile(
                      song: song,
                      onTap: () {
                        ref
                            .read(playerControllerProvider.notifier)
                            .playSong(song);
                        context.push('/player');
                      },
                    ),
                  const SizedBox(height: AppSpacing.xxxl),
                ]),
              ),
            ),
          ],
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppColors.accent),
      ),
      error: (error, stackTrace) => Center(
        child: Text(
          'Library failed to load.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
