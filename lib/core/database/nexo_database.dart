import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'database_connection.dart';

class NexoDatabase extends GeneratedDatabase {
  NexoDatabase._(super.queryExecutor);

  static Future<NexoDatabase> open() async {
    final queryExecutor = await createNexoQueryExecutor();
    final database = NexoDatabase._(queryExecutor);
    await database.migrate();
    return database;
  }

  @override
  int get schemaVersion => 1;

  @override
  Iterable<TableInfo<Table, Object?>> get allTables => const [];

  Future<void> migrate() async {
    await customStatement('''
      CREATE TABLE IF NOT EXISTS recent_searches (
        term TEXT PRIMARY KEY NOT NULL,
        rank INTEGER NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    await customStatement('''
      CREATE TABLE IF NOT EXISTS app_settings (
        key TEXT PRIMARY KEY NOT NULL,
        value TEXT NOT NULL
      )
    ''');
  }

  Future<List<String>> getRecentSearches() async {
    final rows = await customSelect(
      'SELECT term FROM recent_searches ORDER BY rank ASC, updated_at DESC',
    ).get();

    return rows.map((row) => row.read<String>('term')).toList(growable: false);
  }

  Future<void> replaceRecentSearches(List<String> terms) async {
    await transaction(() async {
      await customStatement('DELETE FROM recent_searches');

      for (final entry in terms.asMap().entries) {
        await customStatement(
          '''
            INSERT INTO recent_searches (term, rank, updated_at)
            VALUES (?, ?, ?)
          ''',
          [entry.value, entry.key, DateTime.now().toUtc().toIso8601String()],
        );
      }
    });
  }

  Future<String?> getSetting(String key) async {
    final row = await customSelect(
      'SELECT value FROM app_settings WHERE key = ? LIMIT 1',
      variables: [Variable.withString(key)],
    ).getSingleOrNull();

    return row?.read<String>('value');
  }

  Future<void> setSetting({required String key, required String value}) async {
    await customStatement(
      '''
        INSERT INTO app_settings (key, value)
        VALUES (?, ?)
        ON CONFLICT(key) DO UPDATE SET value = excluded.value
      ''',
      [key, value],
    );
  }
}

final nexoDatabaseProvider = FutureProvider<NexoDatabase>((ref) async {
  final database = await NexoDatabase.open();
  ref.onDispose(() {
    database.close();
  });
  return database;
});
