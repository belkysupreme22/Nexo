import '../../../../core/media/media_item.dart';

class AlbumSummary {
  const AlbumSummary({
    required this.id,
    required this.title,
    required this.artist,
    required this.songCount,
    required this.yearLabel,
    required this.artworkTone,
  });

  final String id;
  final String title;
  final String artist;
  final int songCount;
  final String yearLabel;
  final ArtworkTone artworkTone;
}
