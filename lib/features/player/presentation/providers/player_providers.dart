import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../library/data/repositories/fake_library_repository.dart';
import '../../../library/domain/entities/song.dart';
import '../../../library/presentation/providers/library_providers.dart';
import '../../domain/entities/player_queue_state.dart';

class PlayerController extends StateNotifier<PlayerQueueState> {
  PlayerController(List<Song> seedQueue)
    : super(
        PlayerQueueState(
          queue: seedQueue,
          currentIndex: 0,
          isPlaying: true,
          progress: 0.42,
        ),
      );

  void togglePlayback() {
    state = state.copyWith(isPlaying: !state.isPlaying);
  }

  void playSong(Song song) {
    final index = state.queue.indexWhere((item) => item.id == song.id);
    if (index == -1) {
      final updatedQueue = [...state.queue, song];
      state = state.copyWith(
        queue: updatedQueue,
        currentIndex: updatedQueue.length - 1,
        isPlaying: true,
        progress: 0.08,
      );
      return;
    }

    state = state.copyWith(
      currentIndex: index,
      isPlaying: true,
      progress: 0.08,
    );
  }

  void playNext() {
    if (state.queue.isEmpty) {
      return;
    }

    final nextIndex = (state.currentIndex + 1) % state.queue.length;
    state = state.copyWith(currentIndex: nextIndex, progress: 0.12);
  }

  void playPrevious() {
    if (state.queue.isEmpty) {
      return;
    }

    final previousIndex =
        (state.currentIndex - 1 + state.queue.length) % state.queue.length;
    state = state.copyWith(currentIndex: previousIndex, progress: 0.18);
  }

  void seek(double progress) {
    state = state.copyWith(progress: progress.clamp(0, 1).toDouble());
  }
}

final playerControllerProvider =
    StateNotifierProvider<PlayerController, PlayerQueueState>((ref) {
      final repository = ref.watch(libraryRepositoryProvider);
      final queue = repository is FakeLibraryRepository
          ? repository.seedSongs
          : <Song>[];
      return PlayerController(queue);
    });
