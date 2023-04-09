class LinkValidator {
  static bool isPdfLink(String? value) {
    if (value == null) return false;
    bool isValidUrl = Uri.tryParse(value)?.hasAbsolutePath ?? false;
    bool hasPdf = value.endsWith(".pdf");
    return isValidUrl && hasPdf;
  }
}
