import '../../../../core/media/media_item.dart';

class ArtistSummary {
  const ArtistSummary({
    required this.id,
    required this.name,
    required this.albumCount,
    required this.songCount,
    required this.artworkTone,
  });

  final String id;
  final String name;
  final int albumCount;
  final int songCount;
  final ArtworkTone artworkTone;
}
