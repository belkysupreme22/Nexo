import '../entities/library_overview.dart';
import '../repositories/library_repository.dart';

class GetLibraryOverviewUseCase {
  const GetLibraryOverviewUseCase(this._repository);

  final LibraryRepository _repository;

  Future<LibraryOverview> call() {
    return _repository.getOverview();
  }
}
