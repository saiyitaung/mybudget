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

  Widget build(BuildContext context) {
    var detail = useTextEditingController();
    var amount = useTextEditingController();
    var selectedCurrency = Currency.mmk;
    var selectedCategory = ExpenseCategory.foodanddrink;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("New Expense")),
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
              type: TextInputType.number,
              ctl: amount,
            ),
            SizedBox(
              height: 10,
            ),
            Consumer(builder: ((context, ref, child) {
              final _selectedCategory = ref.watch(expCategoryChangeNotifier);
              selectedCategory = _selectedCategory.expcategory;
              return DropdownButton<ExpenseCategory>(
                  isExpanded: true,
                  dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                  items: expCategories
                      .map(
                        (e) => DropdownMenuItem(
                          child: Container(
                            child: Row(children: [
                              Icon(
                                expCategoryIcons[e.name],
                                color: expCategoryColors[e.name],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(categoriesString[e.name]!)
                            ]),
                          ),
                          value: e,
                        ),
                      )
                      .toList(),
                  value: _selectedCategory.expcategory,
                  onChanged: (v) {
                    _selectedCategory.change(v!);
                    selectedCategory = v;
                  });
            })),
            Consumer(builder: (context, ref, child) {
              final expState = ref.watch(expStateProvider.notifier);
              return TextButton(
                onPressed: () {
                  debugPrint(
                      "${detail.text} ${amount.text} $selectedCurrency $selectedCategory");
                  Navigator.pop(context);
                  final e = Expense(
                      id: Uuid().v4(),
                      detail: detail.text,
                      amount: double.parse(amount.text),
                      timeStamp: DateTime.now(),
                      currency: selectedCurrency.name,
                      expCategory: selectedCategory.name);
                  expState.add(e);
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
