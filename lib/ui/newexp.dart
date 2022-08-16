import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mybudget/myproviders/currencychangeprovider.dart';
import 'package:mybudget/widgets/inputtext.dart';

class NewExpUI extends HookWidget {
  const NewExpUI({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    var detail = useTextEditingController();
    var amount = useTextEditingController();
    var selectedCurrency = Currency.mmk;
   
    return Scaffold(
      body: Column(
        children: [
          Consumer(builder: ((context, ref, child) {
            final selected=ref.watch(currencyChangeNotifier);
            return DropdownButton<Currency>(
                dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                underline: Container(
                  height: .5,
                  color: Colors.blue,
                ),
                isExpanded: true,
                iconSize: 35,
                iconEnabledColor: Colors.white70,
                items: currencies
                    .map((e) => DropdownMenuItem(
                          child: Text(e.name.toString()),
                          value: e,
                        ))
                    .toList(),
                value: selected.currency,
                selectedItemBuilder: ((context) =>
                    currencies.map((e) => Text("${e.name}")).toList()),
                onChanged: (c) {
                  selected.change(c!);
                  selectedCurrency=c;
                });
          })),
          InputTextWidget(
            label: "Detail",
            type: TextInputType.text,
            ctl: detail,
          ),
          InputTextWidget(
            label: "Amount",
            type: TextInputType.text,
            ctl: amount,
          ),
          TextButton(
              onPressed: () {
                debugPrint("${detail.text} ${amount.text} $selectedCurrency");
                Navigator.pop(context);
              },
              child: const Text("Save"))
        ],
      ),
    );
  }
//  void changedCurrency(Currency c){

//  }
}
