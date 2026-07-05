import 'package:flutter_test/flutter_test.dart';
import 'package:job_seeker/utils/translation_utils.dart';

void main() {
  group('TranslationUtils.formatCurrency Tests', () {
    test('Formats LTR currency correctly (amount and code)', () {
      final formatted = TranslationUtils.formatCurrency(5000, 'USD', false);
      expect(formatted, '5,000 USD');
    });

    test('Formats RTL currency correctly with right-to-left marks', () {
      final formatted = TranslationUtils.formatCurrency(12500, 'EGP', true);
      // Expected structure: \u200F12,500 \u200FEGP
      expect(formatted, '\u200F12,500 \u200FEGP');
    });

    test('Formats double amounts correctly', () {
      final formatted = TranslationUtils.formatCurrency(1500.50, 'EUR', false);
      expect(formatted, '1,501 EUR'); // formatted as integer rounding (#,##0)
    });
  });
}
