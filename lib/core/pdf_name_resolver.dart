class PdfNameResolver {
  static getName(String url) {
    return url.split("/").last;
  }
}
