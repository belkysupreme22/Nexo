import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../config/app_environment.dart';

class AppBootstrapState {
  const AppBootstrapState({
    required this.environment,
    required this.backendMode,
    required this.warnings,
  });

  final AppEnvironment environment;
  final NexoBackendMode backendMode;
  final List<String> warnings;
}

class AppBootstrapper {
  const AppBootstrapper(this._environment);

  final AppEnvironment _environment;
  static bool _supabaseInitialized = false;

  Future<AppBootstrapState> initialize() async {
    final warnings = <String>[];
    await SharedPreferences.getInstance();

    if (_environment.hasSupabaseConfig && !_supabaseInitialized) {
      await Supabase.initialize(
        url: _environment.supabaseUrl,
        publishableKey: _environment.supabaseAnonKey,
      );
      _supabaseInitialized = true;
    } else {
      if (!_environment.hasSupabaseConfig) {
        warnings.add(
          'Supabase keys are not configured, so the app is running in local-only mode.',
        );
      }
    }

    if (!_environment.demoLibraryEnabled) {
      warnings.add(
        'Demo library seeding is disabled. Screens may look sparse until local scanning lands.',
      );
    }

    return AppBootstrapState(
      environment: _environment,
      backendMode: _environment.backendMode,
      warnings: warnings,
    );
  }
}

final appEnvironmentProvider = Provider<AppEnvironment>((ref) {
  return AppEnvironment.fromDefines();
});

final appBootstrapperProvider = Provider<AppBootstrapper>((ref) {
  return AppBootstrapper(ref.watch(appEnvironmentProvider));
});

final appBootstrapProvider = FutureProvider<AppBootstrapState>((ref) {
  return ref.watch(appBootstrapperProvider).initialize();
});
