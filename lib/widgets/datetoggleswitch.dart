import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mybudget/myproviders/datetypeprovider.dart';
import 'package:mybudget/utils/utils.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DateToggle extends ConsumerWidget {
  final DateType selectedDateType;
  const DateToggle({Key? key, required this.selectedDateType})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ToggleSwitch(
      initialLabelIndex: getInititalIndex(selectedDateType),
      activeFgColor: Colors.white,
      activeBgColor: const [Colors.teal],
      labels: [
        AppLocalizations.of(context)?.week ?? "",
        AppLocalizations.of(context)?.month ?? "",
        AppLocalizations.of(context)?.year ?? ""
      ],
      onToggle: (index) {
        switch (index) {
          case 0:
            ref
                .read(dateTypeChangeNotifierProvider.notifier)
                .change(DateType.week);
            break;
          case 1:
            ref
                .read(dateTypeChangeNotifierProvider.notifier)
                .change(DateType.month);

            break;
          case 2:
            ref
                .read(dateTypeChangeNotifierProvider.notifier)
                .change(DateType.year);

            break;
        }
        //debugPrint("$index");
      },
    );
  }
}
