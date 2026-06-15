enum NexoBackendMode { localOnly, supabaseConnected }

class AppEnvironment {
  const AppEnvironment({
    required this.appFlavor,
    required this.supabaseUrl,
    required this.supabaseAnonKey,
    required this.demoLibraryEnabled,
  });

  factory AppEnvironment.fromDefines() {
    return AppEnvironment(
      appFlavor: const String.fromEnvironment(
        'NEXO_APP_FLAVOR',
        defaultValue: 'development',
      ),
      supabaseUrl: const String.fromEnvironment('SUPABASE_URL'),
      supabaseAnonKey: const String.fromEnvironment('SUPABASE_ANON_KEY'),
      demoLibraryEnabled: const bool.fromEnvironment(
        'NEXO_ENABLE_DEMO_LIBRARY',
        defaultValue: true,
      ),
    );
  }

  final String appFlavor;
  final String supabaseUrl;
  final String supabaseAnonKey;
  final bool demoLibraryEnabled;

  bool get hasSupabaseConfig =>
      supabaseUrl.trim().isNotEmpty && supabaseAnonKey.trim().isNotEmpty;

  NexoBackendMode get backendMode => hasSupabaseConfig
      ? NexoBackendMode.supabaseConnected
      : NexoBackendMode.localOnly;
}
