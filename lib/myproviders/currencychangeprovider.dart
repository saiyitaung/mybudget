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
final Map<String, Currency> currencyFromStr = {
  Currency.mmk.name: Currency.mmk,
  Currency.yuan.name: Currency.yuan,
  Currency.dollar.name: Currency.dollar,
  Currency.euro.name: Currency.euro,
  Currency.pound.name: Currency.pound,
  Currency.rupee.name: Currency.rupee,
  Currency.baht.name: Currency.baht,
  Currency.yen.name: Currency.yen
};

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
