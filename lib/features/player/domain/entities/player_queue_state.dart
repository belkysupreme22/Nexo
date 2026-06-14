import '../../../library/domain/entities/song.dart';

class PlayerQueueState {
  const PlayerQueueState({
    required this.queue,
    required this.currentIndex,
    required this.isPlaying,
    required this.progress,
  });

  final List<Song> queue;
  final int currentIndex;
  final bool isPlaying;
  final double progress;

  Song? get currentSong {
    if (queue.isEmpty || currentIndex < 0 || currentIndex >= queue.length) {
      return null;
    }

    return queue[currentIndex];
  }

  PlayerQueueState copyWith({
    List<Song>? queue,
    int? currentIndex,
    bool? isPlaying,
    double? progress,
  }) {
    return PlayerQueueState(
      queue: queue ?? this.queue,
      currentIndex: currentIndex ?? this.currentIndex,
      isPlaying: isPlaying ?? this.isPlaying,
      progress: progress ?? this.progress,
    );
  }
}
