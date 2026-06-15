import '../../domain/entities/album_summary.dart';
import '../../domain/entities/artist_summary.dart';
import '../../domain/entities/folder_summary.dart';
import '../../domain/entities/library_overview.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/library_repository.dart';
import '../seeds/demo_library_seed_catalog.dart';

class FakeLibraryRepository implements LibraryRepository {
  FakeLibraryRepository({this.catalog = demoLibrarySeedCatalog});

  final DemoLibrarySeedCatalog catalog;

  List<Song> get seedSongs => catalog.songs;
  List<ArtistSummary> get artists => catalog.artists;
  List<AlbumSummary> get albums => catalog.albums;
  List<FolderSummary> get folders => catalog.folders;

  @override
  Future<LibraryOverview> getOverview() async {
    return LibraryOverview(
      songs: seedSongs,
      artists: artists,
      albums: albums,
      folders: folders,
      recentSearches: catalog.recentSearches,
    );
  }

  @override
  Future<List<Song>> searchSongs(String query) async {
    if (query.trim().isEmpty) {
      return seedSongs;
    }

    final normalized = query.toLowerCase();
    return seedSongs
        .where(
          (song) =>
              song.title.toLowerCase().contains(normalized) ||
              song.artist.toLowerCase().contains(normalized) ||
              song.album.toLowerCase().contains(normalized),
        )
        .toList(growable: false);
  }
}
