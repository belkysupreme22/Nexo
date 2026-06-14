import 'album_summary.dart';
import 'artist_summary.dart';
import 'folder_summary.dart';
import 'song.dart';

class LibraryOverview {
  const LibraryOverview({
    required this.songs,
    required this.artists,
    required this.albums,
    required this.folders,
    required this.recentSearches,
  });

  final List<Song> songs;
  final List<ArtistSummary> artists;
  final List<AlbumSummary> albums;
  final List<FolderSummary> folders;
  final List<String> recentSearches;
}
