import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nexo/app/app.dart';
import 'package:nexo/core/bootstrap/app_bootstrap.dart';
import 'package:nexo/core/config/app_environment.dart';
import 'package:nexo/features/library/domain/entities/recent_search_term.dart';

void main() {
  testWidgets('Nexo app shell renders primary navigation', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appBootstrapProvider.overrideWith(
            (ref) async => const AppBootstrapState(
              environment: AppEnvironment(
                appFlavor: 'test',
                supabaseUrl: '',
                supabaseAnonKey: '',
                demoLibraryEnabled: true,
              ),
              backendMode: NexoBackendMode.localOnly,
              warnings: [],
            ),
          ),
        ],
        child: const NexoApp(),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Nexo'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Library'), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
  });

  test('recent search terms keep newest first, unique, and capped', () {
    final result = buildRecentSearchTerms(
      existing: const [
        RecentSearchTerm('Drake'),
        RecentSearchTerm('The Weeknd'),
        RecentSearchTerm('Ariana Grande'),
      ],
      term: 'drake',
      maxItems: 3,
    );

    expect(result.map((item) => item.value).toList(), [
      'drake',
      'The Weeknd',
      'Ariana Grande',
    ]);
  });
}
