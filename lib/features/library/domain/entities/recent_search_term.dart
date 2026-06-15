class RecentSearchTerm {
  const RecentSearchTerm(this.value);

  final String value;
}

List<RecentSearchTerm> buildRecentSearchTerms({
  required List<RecentSearchTerm> existing,
  required String term,
  int maxItems = 6,
}) {
  final normalized = term.trim();
  if (normalized.isEmpty) {
    return existing;
  }

  final deduped = [
    RecentSearchTerm(normalized),
    ...existing.where(
      (item) => item.value.toLowerCase() != normalized.toLowerCase(),
    ),
  ];

  return deduped.take(maxItems).toList(growable: false);
}
