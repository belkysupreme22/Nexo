import 'package:drift/drift.dart';

import 'database_connection_stub.dart'
    if (dart.library.io) 'database_connection_native.dart'
    as impl;

Future<QueryExecutor> createNexoQueryExecutor() {
  return impl.createNexoQueryExecutor();
}
