import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mybudget/myproviders/currencychangeprovider.dart';

String getCategoryLocal(BuildContext context, String category) {
  String c = "";
  switch (category) {
    case "foodanddrink":
      c = AppLocalizations.of(context)?.foodanddrink ?? " ";
      break;
    case "health":
      c = AppLocalizations.of(context)?.health ?? " ";
      break;
    case "accessories":
      c = AppLocalizations.of(context)?.accessories ?? " ";
      break;
    case "bill":
      c = AppLocalizations.of(context)?.bill ?? " ";
      break;
    case "transportation":
      c = AppLocalizations.of(context)?.transportation ?? " ";
      break;
    case "clothing":
      c = AppLocalizations.of(context)?.clothing ?? " ";
      break;
    case "other":
      c = AppLocalizations.of(context)?.other ?? " ";
      break;
    case "salary":
      c = AppLocalizations.of(context)?.salary ?? " ";
      break;
    case "service":
      c = AppLocalizations.of(context)?.service ?? " ";
      break;
    case "soldProperty":
      c = AppLocalizations.of(context)?.soldProperty ?? " ";
      break;
  }
  return c;
}

String getCurrencyLocale(BuildContext context, Currency currency) {
  switch (currency) {
    case Currency.mmk:
      return AppLocalizations.of(context)?.kyat ?? "";
    case Currency.dollar:
      return AppLocalizations.of(context)?.dollar ?? "";
    case Currency.euro:
      return AppLocalizations.of(context)?.euro ?? "";
    case Currency.pound:
      return AppLocalizations.of(context)?.pound ?? "";
    case Currency.yen:
      return AppLocalizations.of(context)?.yen ?? "";
    case Currency.yuan:
      return AppLocalizations.of(context)?.yuan ?? "";
    case Currency.baht:
      return AppLocalizations.of(context)?.baht ?? "";
    case Currency.rupee:
      return AppLocalizations.of(context)?.rupee ?? "";
  }
}
