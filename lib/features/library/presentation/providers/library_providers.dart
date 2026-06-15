import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/bootstrap/app_bootstrap.dart';
import '../../data/repositories/fake_library_repository.dart';
import '../../data/seeds/demo_library_seed_catalog.dart';
import '../../domain/entities/library_overview.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/library_repository.dart';
import '../../domain/usecases/get_library_overview_use_case.dart';
import '../../domain/usecases/search_library_use_case.dart';

final demoLibrarySeedCatalogProvider = Provider<DemoLibrarySeedCatalog>((ref) {
  return demoLibrarySeedCatalog;
});

final libraryRepositoryProvider = Provider<LibraryRepository>((ref) {
  final environment = ref.watch(appEnvironmentProvider);
  final catalog = ref.watch(demoLibrarySeedCatalogProvider);

  if (environment.demoLibraryEnabled) {
    return FakeLibraryRepository(catalog: catalog);
  }

  return FakeLibraryRepository(
    catalog: const DemoLibrarySeedCatalog(
      songs: [],
      artists: [],
      albums: [],
      folders: [],
      recentSearches: [],
    ),
  );
});

final libraryOverviewUseCaseProvider = Provider<GetLibraryOverviewUseCase>((
  ref,
) {
  return GetLibraryOverviewUseCase(ref.watch(libraryRepositoryProvider));
});

final searchLibraryUseCaseProvider = Provider<SearchLibraryUseCase>((ref) {
  return SearchLibraryUseCase(ref.watch(libraryRepositoryProvider));
});

final libraryOverviewProvider = FutureProvider<LibraryOverview>((ref) {
  return ref.watch(libraryOverviewUseCaseProvider).call();
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final songSearchResultsProvider = FutureProvider<List<Song>>((ref) {
  final query = ref.watch(searchQueryProvider);
  return ref.watch(searchLibraryUseCaseProvider).call(query);
});
