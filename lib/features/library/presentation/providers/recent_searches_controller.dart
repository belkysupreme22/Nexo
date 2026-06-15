import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/preferences/app_preferences_providers.dart';
import '../../domain/entities/recent_search_term.dart';

class RecentSearchesController extends AsyncNotifier<List<RecentSearchTerm>> {
  @override
  Future<List<RecentSearchTerm>> build() async {
    final preferences = await ref.watch(appPreferencesProvider.future);
    return preferences.readRecentSearches().map(RecentSearchTerm.new).toList();
  }

  Future<void> remember(String term) async {
    final preferences = await ref.read(appPreferencesProvider.future);
    final current = state.valueOrNull ?? <RecentSearchTerm>[];
    final updated = buildRecentSearchTerms(existing: current, term: term);

    state = AsyncData(updated);
    await preferences.saveRecentSearches(
      updated.map((item) => item.value).toList(),
    );
  }

  Future<void> remove(String term) async {
    final preferences = await ref.read(appPreferencesProvider.future);
    final current = state.valueOrNull ?? <RecentSearchTerm>[];
    final updated = current
        .where((item) => item.value.toLowerCase() != term.toLowerCase())
        .toList(growable: false);

    state = AsyncData(updated);
    await preferences.saveRecentSearches(
      updated.map((item) => item.value).toList(),
    );
  }
}

final recentSearchesControllerProvider =
    AsyncNotifierProvider<RecentSearchesController, List<RecentSearchTerm>>(
      RecentSearchesController.new,
    );
