import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_search_field.dart';
import '../providers/library_providers.dart';
import '../widgets/song_list_tile.dart';
import '../../../player/presentation/providers/player_providers.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: ref.read(searchQueryProvider));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final overviewAsync = ref.watch(libraryOverviewProvider);
    final searchResultsAsync = ref.watch(songSearchResultsProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Search', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: AppSpacing.md),
            AppSearchField(
              controller: _controller,
              onChanged: (value) =>
                  ref.read(searchQueryProvider.notifier).state = value,
              hintText: 'Artists, songs, albums',
            ),
            const SizedBox(height: AppSpacing.xl),
            Expanded(
              child: searchResultsAsync.when(
                data: (songs) {
                  final query = ref.watch(searchQueryProvider);
                  if (query.isEmpty) {
                    return overviewAsync.when(
                      data: (overview) => ListView(
                        children: [
                          Text(
                            'Recent Searches',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          ...overview.recentSearches.map(
                            (term) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(term),
                              trailing: const Icon(
                                Icons.close_rounded,
                                color: AppColors.textMuted,
                              ),
                              onTap: () {
                                _controller.text = term;
                                ref.read(searchQueryProvider.notifier).state =
                                    term;
                              },
                            ),
                          ),
                        ],
                      ),
                      loading: () => const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.accent,
                        ),
                      ),
                      error: (error, stackTrace) => const SizedBox.shrink(),
                    );
                  }

                  if (songs.isEmpty) {
                    return Center(
                      child: Text(
                        'No matches for "$query".',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: songs.length,
                    itemBuilder: (context, index) {
                      final song = songs[index];
                      return SongListTile(
                        song: song,
                        onTap: () {
                          ref
                              .read(playerControllerProvider.notifier)
                              .playSong(song);
                          context.push('/player');
                        },
                      );
                    },
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(color: AppColors.accent),
                ),
                error: (error, stackTrace) => Center(
                  child: Text(
                    'Search is unavailable.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
