import 'media_source.dart';

enum MediaType { song, video, podcast, audiobook, liveStream }

enum ArtworkTone { ember, rose, ocean, pulse, forest }

abstract class MediaItem {
  const MediaItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.durationLabel,
    required this.mediaType,
    required this.source,
    required this.artworkTone,
  });

  final String id;
  final String title;
  final String subtitle;
  final String durationLabel;
  final MediaType mediaType;
  final MediaSource source;
  final ArtworkTone artworkTone;
}
