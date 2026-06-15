import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_preferences.dart';

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((
  ref,
) async {
  return SharedPreferences.getInstance();
});

final appPreferencesProvider = FutureProvider<AppPreferences>((ref) async {
  final sharedPreferences = await ref.watch(sharedPreferencesProvider.future);
  return AppPreferences(sharedPreferences);
});
