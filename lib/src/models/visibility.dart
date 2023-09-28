///
/// Possible values for the visibility of a Pastebin [Paste]
///
enum Visibility { public, unlisted, private, unknown }

extension VisibilityExtension on Visibility? {
  static const Map<Visibility, String> values = {
    Visibility.public: '0',
    Visibility.unlisted: '1',
    Visibility.private: '2',
    Visibility.unknown: '',
  };

  static Visibility parse(final String? visibility) {
    final entry = values.entries.firstWhere(
      (entry) => entry.value == visibility,
      orElse: () => MapEntry(Visibility.unknown, ''),
    );

    return entry.key;
  }

  static Visibility tryParse(final String? visibility) => parse(visibility);

  String? value() => values[this!];
}
