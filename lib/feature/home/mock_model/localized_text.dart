class LocalizedText {
  final String ar;
  final String en;

  const LocalizedText({required this.ar, required this.en});

  String of(String languageCode) => languageCode == 'ar' ? ar : en;
}
