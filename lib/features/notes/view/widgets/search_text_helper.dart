String normalizeSearchText(String text) {
  return text
      .toLowerCase()
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
}