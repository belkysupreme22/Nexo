import '../../../../core/media/media_item.dart';

class Song extends MediaItem {
  const Song({
    required super.id,
    required super.title,
    required super.subtitle,
    required super.durationLabel,
    required super.source,
    required super.artworkTone,
    required this.artist,
    required this.album,
    required this.lyricsPreview,
    required this.isFavorite,
  }) : super(mediaType: MediaType.song);

  final String artist;
  final String album;
  final String lyricsPreview;
  final bool isFavorite;
}
