// riverpod/lib/core/helpers/extensions.dart
extension StringExtension on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}
