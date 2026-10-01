import 'package:intl/intl.dart';

abstract final class AppDigits {
  static const List<String> arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

  static String format(num value, String languageCode) {
    return localize(NumberFormat('#,##0', 'en').format(value), languageCode);
  }

  static String decimal(num value, String languageCode) {
    return localize(value.toStringAsFixed(1), languageCode);
  }

  static String localize(String text, String languageCode) {
    if (languageCode != 'ar') return text;
    return text.split('').map((char) {
      if (char == ',') return '٬';
      if (char == '.') return '٫';
      final digit = int.tryParse(char);
      return digit == null ? char : arabicDigits[digit];
    }).join();
  }
}
