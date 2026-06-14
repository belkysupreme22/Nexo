enum MediaSourceType {
  device,
  spotify,
  drive,
  dropbox,
  oneDrive,
  plex,
  jellyfin,
}

class MediaSource {
  const MediaSource({
    required this.id,
    required this.type,
    required this.label,
  });

  final String id;
  final MediaSourceType type;
  final String label;
}
