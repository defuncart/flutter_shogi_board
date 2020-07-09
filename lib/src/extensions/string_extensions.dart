/// A class of extension methods for String
extension StringExtensions on String {
  /// Whether the string is both not null and not empty
  bool get isNotNullNorEmpty => this != null && isNotEmpty;
}
