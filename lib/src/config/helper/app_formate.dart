import 'package:intl/intl.dart';

class AppFormatter {
  static final NumberFormat _currencyFormatter = NumberFormat.currency(
    locale: 'en_US', // separa miles con comas y usa punto decimal
    symbol: '\$',    // símbolo que se mostrará
    decimalDigits: 2,
  );

  static String currency(double value) {
    return _currencyFormatter.format(value);
  }
}
