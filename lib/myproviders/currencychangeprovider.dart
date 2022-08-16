import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Currency { mmk, yuan, dollar, euro, pound, rupee, baht, yen }

const currencies = [
  Currency.mmk,
  Currency.yuan,
  Currency.dollar,
  Currency.euro,
  Currency.pound,
  Currency.rupee,
  Currency.baht,
  Currency.yen
];

class CurrencChangeNotifier extends ChangeNotifier {
  Currency currency = Currency.mmk;
  change(Currency c) {
    currency = c;
    notifyListeners();
  }
  Currency get value => currency;
}

final currencyChangeNotifier = ChangeNotifierProvider<CurrencChangeNotifier>(
    (ref) => CurrencChangeNotifier());
