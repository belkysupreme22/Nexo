import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/preferences/app_preferences_providers.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/artwork_tile.dart';
import '../../../player/presentation/providers/player_providers.dart';
import '../../domain/entities/library_overview.dart';
import '../providers/library_providers.dart';
import '../widgets/song_list_tile.dart';

enum LibraryTab {
  songs('Songs'),
  artists('Artists'),
  albums('Albums'),
  folders('Folders');

  const LibraryTab(this.label);

  final String label;

  String get storageValue => name;

  static LibraryTab fromStorageValue(String value) {
    return LibraryTab.values.firstWhere(
      (tab) => tab.storageValue == value,
      orElse: () => LibraryTab.songs,
    );
  }
}

class LibraryScreen extends ConsumerStatefulWidget {
  const LibraryScreen({super.key});

  @override
  ConsumerState<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends ConsumerState<LibraryScreen> {
  LibraryTab _selectedTab = LibraryTab.songs;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final preferences = await ref.read(appPreferencesProvider.future);
      final storedTab = preferences.readPreferredLibraryTab();
      if (!mounted) {
        return;
      }

      setState(() {
        _selectedTab = LibraryTab.fromStorageValue(storedTab);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final overviewAsync = ref.watch(libraryOverviewProvider);

    return overviewAsync.when(
      data: (overview) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Library',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const Spacer(),
                    const Icon(AppIcons.search, color: AppColors.textMuted),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: LibraryTab.values
                        .map((tab) {
                          final isSelected = tab == _selectedTab;
                          return Padding(
                            padding: const EdgeInsets.only(
                              right: AppSpacing.xs,
                            ),
                            child: ChoiceChip(
                              label: Text(tab.label),
                              selected: isSelected,
                              onSelected: (_) => _selectTab(tab),
                              labelStyle: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(
                                    color: isSelected
                                        ? AppColors.textPrimary
                                        : AppColors.textSecondary,
                                  ),
                              selectedColor: AppColors.accentDeep,
                              backgroundColor: AppColors.surface,
                              side: BorderSide.none,
                            ),
                          );
                        })
                        .toList(growable: false),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Expanded(child: _buildTabBody(context, overview)),
              ],
            ),
          ),
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

  Widget _buildTabBody(BuildContext context, LibraryOverview overview) {
    switch (_selectedTab) {
      case LibraryTab.songs:
        return ListView.builder(
          itemCount: overview.songs.length,
          itemBuilder: (context, index) {
            final song = overview.songs[index];
            return SongListTile(
              song: song,
              onTap: () {
                ref.read(playerControllerProvider.notifier).playSong(song);
                context.push('/player');
              },
            );
          },
        );
      case LibraryTab.artists:
        return ListView.separated(
          itemCount: overview.artists.length,
          separatorBuilder: (context, index) =>
              const SizedBox(height: AppSpacing.md),
          itemBuilder: (context, index) {
            final artist = overview.artists[index];
            return Row(
              children: [
                ArtworkTile(
                  tone: artist.artworkTone,
                  label: artist.name,
                  size: 72,
                  borderRadius: 36,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        artist.name,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        '${artist.albumCount} album  |  ${artist.songCount} songs',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      case LibraryTab.albums:
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: AppSpacing.md,
            crossAxisSpacing: AppSpacing.md,
            childAspectRatio: 0.84,
          ),
          itemCount: overview.albums.length,
          itemBuilder: (context, index) {
            final album = overview.albums[index];
            return Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppSpacing.md),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ArtworkTile(
                      tone: album.artworkTone,
                      label: album.title,
                      size: double.infinity,
                      borderRadius: AppSpacing.md,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    album.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    album.artist,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
                  ),
                ],
              ),
            );
          },
        );
      case LibraryTab.folders:
        return ListView.separated(
          itemCount: overview.folders.length,
          separatorBuilder: (context, index) =>
              const SizedBox(height: AppSpacing.sm),
          itemBuilder: (context, index) {
            final folder = overview.folders[index];
            return Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppSpacing.md),
              ),
              child: Row(
                children: [
                  const Icon(
                    AppIcons.folder,
                    color: AppColors.accent,
                    size: 28,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          folder.name,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: AppSpacing.xxs),
                        Text(
                          '${folder.songCount} songs',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppColors.textMuted),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
    }
  }

  Future<void> _selectTab(LibraryTab tab) async {
    setState(() {
      _selectedTab = tab;
    });

    final preferences = await ref.read(appPreferencesProvider.future);
    await preferences.savePreferredLibraryTab(tab.storageValue);
  }
}
