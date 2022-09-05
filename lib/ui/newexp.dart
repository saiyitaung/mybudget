import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mybudget/entities/budgetcategory.dart';
import 'package:mybudget/entities/expense.dart';
import 'package:mybudget/myproviders/currencychangeprovider.dart';
import 'package:mybudget/myproviders/expcategoryprovider.dart';
import 'package:mybudget/myproviders/expstateprovider.dart';
import 'package:mybudget/utils/utils.dart';
import 'package:mybudget/widgets/inputtext.dart';
import 'package:uuid/uuid.dart';

class NewExpUI extends HookWidget {
  const NewExpUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var detail = useTextEditingController();
    var amount = useTextEditingController();
    var selectedCurrency = Currency.mmk;
    var selectedCategory = ExpenseCategory.foodanddrink;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text("New Expense")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text("Currency"),
              SizedBox(
                height: 50,
                width: 200,
                child: Consumer(builder: ((context, ref, child) {
                  final selected = ref.watch(currencyChangeNotifier);
                  selectedCurrency = selected.currency;
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
                                value: e,
                                child: Text(e.name),
                              ))
                          .toList(),
                      value: selected.currency,
                      selectedItemBuilder: ((context) => currencies
                          .map((e) => Container(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                ),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  e.name,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ))
                          .toList()),
                      onChanged: (c) {
                        selected.change(c!);
                        selectedCurrency = c;
                      });
                })),
              ),
            ]),
            Consumer(builder: (context, ref, child) {
              return InputTextWidget(
                label: "Detail",
                type: TextInputType.text,
                ctl: detail,
                autoCompleteText:
                    ref.watch(expStateProvider).map((e) => e.detail).toSet().toList(),
              );
            }),
            const SizedBox(
              height: 10,
            ),
            InputTextWidget(
              label: "Amount",
              type: TextInputType.number,
              ctl: amount,
              autoCompleteText: [],
            ),
            const SizedBox(
              height: 10,
            ),
            Consumer(builder: ((context, ref, child) {
              final _selectedCategory = ref.watch(expCategoryChangeNotifier);
              selectedCategory = _selectedCategory.expcategory;
              return DropdownButton<ExpenseCategory>(
                borderRadius: BorderRadius.circular(10),
                underline: const SizedBox(),
                isExpanded: true,
                dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                items: expCategories
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Row(children: [
                          Icon(
                            expCategoryIcons[e.name],
                            color: expCategoryColors[e.name],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(categoriesString[e.name]!)
                        ]),
                      ),
                    )
                    .toList(),
                value: _selectedCategory.expcategory,
                onChanged: (v) {
                  _selectedCategory.change(v!);
                  selectedCategory = v;
                },
                selectedItemBuilder: (context) => expCategories
                    .map(
                      (e) => Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(children: [
                          Icon(
                            expCategoryIcons[e.name],
                            color: expCategoryColors[e.name],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(categoriesString[e.name]!)
                        ]),
                      ),
                    )
                    .toList(),
              );
            })),
            const SizedBox(
              height: 10,
            ),
            Consumer(builder: (context, ref, child) {
              final expState = ref.watch(expStateProvider.notifier);
              return TextButton(
                onPressed: () {
                  final e = Expense(
                      id: const Uuid().v4(),
                      detail: detail.text,
                      amount:
                          double.parse(amount.text == '' ? '0.0' : amount.text),
                      timeStamp: DateTime.now(),
                      currency: selectedCurrency.name,
                      expCategory: selectedCategory.name);
                  if (e.detail != '' && e.amount > 0) {
                    expState.add(e);
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white60),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text(
                    "save",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
