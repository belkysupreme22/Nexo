import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  AppPreferences(this._sharedPreferences);

  static const defaultRecentSearches = <String>[
    'Ariana Grande',
    'Morgan Wallen',
    'Justin Bieber',
    'Drake',
    'Olivia Rodrigo',
    'The Weeknd',
  ];

  static const defaultLibraryTab = 'songs';

  static const _recentSearchesKey = 'search.recent_terms';
  static const _preferredLibraryTabKey = 'library.preferred_tab';

  final SharedPreferences _sharedPreferences;

  List<String> readRecentSearches() {
    final saved = _sharedPreferences.getStringList(_recentSearchesKey);
    if (saved == null || saved.isEmpty) {
      return defaultRecentSearches;
    }

    return saved;
  }

  Future<void> saveRecentSearches(List<String> searches) {
    return _sharedPreferences.setStringList(_recentSearchesKey, searches);
  }

  String readPreferredLibraryTab() {
    return _sharedPreferences.getString(_preferredLibraryTabKey) ??
        defaultLibraryTab;
  }

  Future<void> savePreferredLibraryTab(String value) {
    return _sharedPreferences.setString(_preferredLibraryTabKey, value);
  }
}
