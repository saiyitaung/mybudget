import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mybudget/entities/budgetcategory.dart';
import 'package:mybudget/entities/income.dart';
import 'package:mybudget/myproviders/currencychangeprovider.dart';
import 'package:mybudget/myproviders/incomeprovider.dart';
import 'package:mybudget/utils/utils.dart';
import 'package:mybudget/widgets/inputtext.dart';
import 'package:uuid/uuid.dart';

class NewIncomeUI extends HookWidget {
  const NewIncomeUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var detail = useTextEditingController();
    var amount = useTextEditingController();
    var selectedCurrency = Currency.mmk;
    var selectedCategory = IncomeCategory.salary;
    return Scaffold(
      appBar: AppBar(title: Text("New Income")),
      body: Padding(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Currency"),
              SizedBox(
                height: 50,
                width: 200,
                child: Consumer(builder: ((context, ref, child) {
                  final selected = ref.watch(currencyChangeNotifier);
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
                      selectedItemBuilder: ((context) => currencies
                          .map((e) => Container(
                                child: Text(
                                  "${e.name}",
                                  style: TextStyle(color: Colors.white),
                                ),
                                padding: EdgeInsets.only(
                                  left: 20,
                                ),
                                alignment: Alignment.centerLeft,
                              ))
                          .toList()),
                      onChanged: (c) {
                        selected.change(c!);
                        selectedCurrency = c;
                      });
                })),
              ),
            ]),
            InputTextWidget(
              label: "Detail",
              type: TextInputType.text,
              ctl: detail,
            ),
            SizedBox(
              height: 10,
            ),
            InputTextWidget(
              label: "Amount",
              type: TextInputType.text,
              ctl: amount,
            ),
            SizedBox(
              height: 10,
            ),
            Consumer(builder: (context, ref, child) {
              return DropdownButton<IncomeCategory>(
                  isExpanded: true,
                  dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                  items: inCategories
                      .map(
                        (e) => DropdownMenuItem(
                          child: Container(
                              child: Row(
                            children: [
                              Icon(
                                inCategoryIcons[e.name],
                                color: Colors.green,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(e.name),
                            ],
                          )),
                          value: e,
                        ),
                      )
                      .toList(),
                  value: ref.watch(inCategoryChangeNotifier).incategory,
                  onChanged: (v) {
                    selectedCategory=v!;
                    ref.read(inCategoryChangeNotifier).change(v);
                  });
            }),
            Consumer(builder: (context, ref, child) {
              final _incomeState = ref.watch(incomeStateNotifier.notifier);
              return TextButton(
                onPressed: () {
                  debugPrint("${detail.text} ${amount.text} $selectedCurrency");
                  var newItem = InCome(
                      id: Uuid().v4(),
                      detail: detail.text,
                      amount: double.parse(amount.text),
                      currency: selectedCurrency.name,
                      timeStamp: DateTime.now(),
                      inCategory: selectedCategory.name);
                  _incomeState.add(newItem);
                  Navigator.pop(context);
                },
                child: Container(
                  child: const Text(
                    "save",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  alignment: Alignment.center,
                ),
              );
            }),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 20),
      ),
    );
  }
}
