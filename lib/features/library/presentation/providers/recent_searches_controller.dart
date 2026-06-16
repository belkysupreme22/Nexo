import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/nexo_database.dart';
import '../../../../core/preferences/app_preferences.dart';
import '../../domain/entities/recent_search_term.dart';

class RecentSearchesController extends AsyncNotifier<List<RecentSearchTerm>> {
  @override
  Future<List<RecentSearchTerm>> build() async {
    final database = await ref.watch(nexoDatabaseProvider.future);
    var searches = await database.getRecentSearches();

    if (searches.isEmpty) {
      searches = AppPreferences.defaultRecentSearches;
      await database.replaceRecentSearches(searches);
    }

    return searches.map(RecentSearchTerm.new).toList();
  }

  Future<void> remember(String term) async {
    final database = await ref.read(nexoDatabaseProvider.future);
    final current = state.valueOrNull ?? <RecentSearchTerm>[];
    final updated = buildRecentSearchTerms(existing: current, term: term);

    state = AsyncData(updated);
    await database.replaceRecentSearches(
      updated.map((item) => item.value).toList(),
    );
  }

  Future<void> remove(String term) async {
    final database = await ref.read(nexoDatabaseProvider.future);
    final current = state.valueOrNull ?? <RecentSearchTerm>[];
    final updated = current
        .where((item) => item.value.toLowerCase() != term.toLowerCase())
        .toList(growable: false);

    state = AsyncData(updated);
    await database.replaceRecentSearches(
      updated.map((item) => item.value).toList(),
    );
  }
}

final recentSearchesControllerProvider =
    AsyncNotifierProvider<RecentSearchesController, List<RecentSearchTerm>>(
      RecentSearchesController.new,
    );
