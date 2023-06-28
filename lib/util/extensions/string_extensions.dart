extension StringExt on String {
  String toSlug() {
    return split(" ").map((e) => e.trim().toLowerCase()).join("_");
  }
}
