import '../entities/song.dart';
import '../repositories/library_repository.dart';

class SearchLibraryUseCase {
  const SearchLibraryUseCase(this._repository);

  final LibraryRepository _repository;

  Future<List<Song>> call(String query) {
    return _repository.searchSongs(query);
  }
}
