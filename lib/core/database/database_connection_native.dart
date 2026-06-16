import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

Future<QueryExecutor> createNexoQueryExecutor() async {
  final documentsDirectory = await getApplicationDocumentsDirectory();
  final databaseFile = File(p.join(documentsDirectory.path, 'nexo.sqlite'));

  return NativeDatabase.createInBackground(databaseFile);
}
