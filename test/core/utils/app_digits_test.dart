import 'package:flutter_test/flutter_test.dart';
import 'package:test_ui/core/utils/app_digits.dart';

void main() {
  group('AppDigits.format', () {
    test('adds thousands separators in English', () {
      expect(AppDigits.format(1222, 'en'), '1,222');
    });

    test('uses Arabic digits and separator in Arabic', () {
      expect(AppDigits.format(10000, 'ar'), '١٠٬٠٠٠');
    });
  });

  group('AppDigits.decimal', () {
    test('keeps one decimal place', () {
      expect(AppDigits.decimal(4, 'en'), '4.0');
      expect(AppDigits.decimal(4.85, 'en'), anyOf('4.8', '4.9'));
    });

    test('uses the Arabic decimal separator in Arabic', () {
      expect(AppDigits.decimal(4.8, 'ar'), '٤٫٨');
    });
  });

  group('AppDigits.localize', () {
    test('leaves non-digit characters untouched', () {
      expect(AppDigits.localize('(982)', 'ar'), '(٩٨٢)');
    });

    test('returns the text unchanged for non-Arabic languages', () {
      expect(AppDigits.localize('1,234.5', 'en'), '1,234.5');
    });
  });
}
