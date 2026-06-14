import '../entities/library_overview.dart';
import '../entities/song.dart';

abstract class LibraryRepository {
  Future<LibraryOverview> getOverview();

  Future<List<Song>> searchSongs(String query);
}
