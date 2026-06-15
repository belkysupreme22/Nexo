import '../../../../core/media/media_item.dart';
import '../../../../core/media/media_source.dart';
import '../../domain/entities/album_summary.dart';
import '../../domain/entities/artist_summary.dart';
import '../../domain/entities/folder_summary.dart';
import '../../domain/entities/song.dart';

class DemoLibrarySeedCatalog {
  const DemoLibrarySeedCatalog({
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

const MediaSource _deviceSource = MediaSource(
  id: 'device-primary',
  type: MediaSourceType.device,
  label: 'Device',
);

const demoLibrarySeedCatalog = DemoLibrarySeedCatalog(
  songs: [
    Song(
      id: 'starboy',
      title: 'Starboy',
      subtitle: 'The Weeknd, Daft Punk',
      durationLabel: '03:50',
      source: _deviceSource,
      artworkTone: ArtworkTone.ocean,
      artist: 'The Weeknd',
      album: 'Dawn FM',
      lyricsPreview:
          'Let a rich life brag loud, boulevard lights and a midnight engine.',
      isFavorite: true,
    ),
    Song(
      id: 'disaster',
      title: 'Disaster',
      subtitle: 'Conan Gray',
      durationLabel: '03:58',
      source: _deviceSource,
      artworkTone: ArtworkTone.rose,
      artist: 'Conan Gray',
      album: 'Superache',
      lyricsPreview:
          'You make chaos sound cinematic and somehow still intimate.',
      isFavorite: false,
    ),
    Song(
      id: 'handsome',
      title: 'HANDSOME',
      subtitle: 'Warren Hue',
      durationLabel: '04:18',
      source: _deviceSource,
      artworkTone: ArtworkTone.ember,
      artist: 'Warren Hue',
      album: 'Boy of the Year',
      lyricsPreview:
          'Bright neon ego, heavy drums, a grin with too much confidence.',
      isFavorite: false,
    ),
    Song(
      id: 'sharks',
      title: 'Sharks',
      subtitle: 'Imagine Dragons',
      durationLabel: '03:23',
      source: _deviceSource,
      artworkTone: ArtworkTone.forest,
      artist: 'Imagine Dragons',
      album: 'Mercury',
      lyricsPreview: 'Teeth in the water, all swagger and consequence.',
      isFavorite: true,
    ),
    Song(
      id: 'fly-me-to-the-sun',
      title: 'Fly Me To The Sun',
      subtitle: 'Romanic Echoes',
      durationLabel: '04:20',
      source: _deviceSource,
      artworkTone: ArtworkTone.pulse,
      artist: 'Romanic Echoes',
      album: 'Zero Hour',
      lyricsPreview:
          'A dreamy lift-off with enough tension to keep the night moving.',
      isFavorite: false,
    ),
    Song(
      id: 'bended-man',
      title: 'The Bended Man',
      subtitle: 'Sumwich',
      durationLabel: '04:08',
      source: _deviceSource,
      artworkTone: ArtworkTone.rose,
      artist: 'Sumwich',
      album: 'Fragments',
      lyricsPreview:
          'Bent shapes, soft drums, and a voice that feels half-confession.',
      isFavorite: false,
    ),
    Song(
      id: 'god-is-a-woman',
      title: 'God Is A Woman',
      subtitle: 'Ariana Grande',
      durationLabel: '03:17',
      source: _deviceSource,
      artworkTone: ArtworkTone.ember,
      artist: 'Ariana Grande',
      album: 'Sweetener',
      lyricsPreview: 'Smooth confidence floating over late-night synth velvet.',
      isFavorite: true,
    ),
    Song(
      id: 'pain',
      title: 'Pain (Official)',
      subtitle: 'Ryan Jones',
      durationLabel: '03:21',
      source: _deviceSource,
      artworkTone: ArtworkTone.pulse,
      artist: 'Ryan Jones',
      album: 'Pain',
      lyricsPreview: 'Minimal, bruised, and direct in a way that sticks.',
      isFavorite: false,
    ),
  ],
  artists: [
    ArtistSummary(
      id: 'ariana-grande',
      name: 'Ariana Grande',
      albumCount: 1,
      songCount: 20,
      artworkTone: ArtworkTone.rose,
    ),
    ArtistSummary(
      id: 'the-weeknd',
      name: 'The Weeknd',
      albumCount: 1,
      songCount: 18,
      artworkTone: ArtworkTone.ocean,
    ),
    ArtistSummary(
      id: 'acidrap',
      name: 'Acidrap',
      albumCount: 2,
      songCount: 18,
      artworkTone: ArtworkTone.pulse,
    ),
    ArtistSummary(
      id: 'ania-szormarch',
      name: 'Ania Szormarch',
      albumCount: 1,
      songCount: 12,
      artworkTone: ArtworkTone.forest,
    ),
  ],
  albums: [
    AlbumSummary(
      id: 'dawn-fm',
      title: 'Dawn FM',
      artist: 'The Weeknd',
      songCount: 16,
      yearLabel: '2022',
      artworkTone: ArtworkTone.ocean,
    ),
    AlbumSummary(
      id: 'sweetener',
      title: 'Sweetener',
      artist: 'Ariana Grande',
      songCount: 16,
      yearLabel: '2018',
      artworkTone: ArtworkTone.rose,
    ),
    AlbumSummary(
      id: 'first-impact',
      title: 'First Impact',
      artist: 'Treasures',
      songCount: 14,
      yearLabel: '2021',
      artworkTone: ArtworkTone.pulse,
    ),
    AlbumSummary(
      id: 'pain',
      title: 'Pain',
      artist: 'Ryan Jones',
      songCount: 9,
      yearLabel: '2023',
      artworkTone: ArtworkTone.ember,
    ),
  ],
  folders: [
    FolderSummary(id: 'billboards', name: 'Top 100 Billboards', songCount: 100),
    FolderSummary(id: 'favorites', name: 'My Favorite Songs', songCount: 403),
    FolderSummary(id: 'ariana', name: 'Ariana Grande', songCount: 48),
    FolderSummary(id: 'popular', name: 'Most Popular Songs', songCount: 103),
  ],
  recentSearches: [
    'Ariana Grande',
    'Morgan Wallen',
    'Justin Bieber',
    'Drake',
    'Olivia Rodrigo',
    'The Weeknd',
  ],
);
