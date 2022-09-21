import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Text(
        "${AppLocalizations.of(context)?.delete}",
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
      content: Text(
        "${AppLocalizations.of(context)?.delmsg}",
        textAlign: TextAlign.center,
      ),
      actions: [
        Container(
          child: Row(
            
            children: [
              Flexible(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    child: Text(
                      "${AppLocalizations.of(context)?.cancel}",
                      style: const TextStyle(color: Colors.red),
                    ),
                    onPressed: () => Navigator.pop(context, false),
                  ),
                ),
              ),
              const SizedBox(width: 5,),
              Flexible(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    child:   Text(
                      "${AppLocalizations.of(context)?.confirm}",
                      style: const TextStyle(color: Colors.green),
                    ),
                    onPressed: () => Navigator.pop(context, true),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
