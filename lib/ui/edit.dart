import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mybudget/entities/budget.dart';
import 'package:mybudget/entities/budgetcategory.dart';
import 'package:mybudget/entities/expense.dart';
import 'package:mybudget/entities/income.dart';
import 'package:mybudget/myproviders/currencychangeprovider.dart';
import 'package:mybudget/myproviders/expcategoryprovider.dart';
import 'package:mybudget/myproviders/expstateprovider.dart';
import 'package:mybudget/myproviders/incomeprovider.dart';
import 'package:mybudget/utils/utils.dart';
import 'package:mybudget/widgets/inputtext.dart';

class Edit<T extends Budget> extends HookWidget {
  final T t;
  const Edit({Key? key, required this.t}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final detailCtrl = useTextEditingController(text: t.detail);
    final amountCtrl = useTextEditingController(text: t.amount.toString());
    var selectedCurrency = currencyFromStr[t.currency] ?? Currency.mmk;

    return Scaffold(
      appBar: AppBar(title: Text("Edit")),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(children: [
          SizedBox(
            height: 10,
          ),
          Consumer(
            builder: (context, ref, child) {
              return InputTextWidget(
                label: "Detail",
                type: TextInputType.name,
                ctl: detailCtrl,
                autoCompleteText: t is Expense
                    ? ref.watch(expStateProvider).map((e) => e.detail).toSet().toList()
                    : ref
                        .watch(incomeStateNotifier)
                        .map((e) => e.detail).toSet()
                        .toList(),
              );
            },
          ),
          SizedBox(
            height: 10,
          ),
          InputTextWidget(
            label: "Amount",
            type: TextInputType.number,
            ctl: amountCtrl,
            autoCompleteText: [],
          ),
          SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text("Currency"),
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
                    value: selectedCurrency,
                    selectedItemBuilder: ((context) => currencies
                        .map((e) => Container(
                              padding: const EdgeInsets.only(
                                left: 20,
                              ),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                e.name,
                                style: TextStyle(color: Colors.white),
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
          const SizedBox(
            height: 10,
          ),
          t is Expense
              ? Consumer(builder: ((context, ref, child) {
                  final _selectedCategory =
                      ref.watch(expCategoryChangeNotifier);

                  return DropdownButton<ExpenseCategory>(
                      isExpanded: true,
                      dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                      items: expCategories
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: SizedBox(
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
                            ),
                          )
                          .toList(),
                      value: _selectedCategory.expcategory,
                      onChanged: (v) {
                        _selectedCategory.change(v!);
                      });
                }))
              : Consumer(builder: (context, ref, child) {
                  var selectedCategory =
                      ref.watch(inCategoryChangeNotifier).incategory;
                  return DropdownButton<IncomeCategory>(
                      isExpanded: true,
                      dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                      items: inCategories
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Row(
                                children: [
                                  Icon(
                                    inCategoryIcons[e.name],
                                    color: Colors.green,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(e.name),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                      value: ref.watch(inCategoryChangeNotifier).incategory,
                      onChanged: (v) {
                        selectedCategory = v!;
                        ref.read(inCategoryChangeNotifier).change(v);
                      });
                }),
          SizedBox(
            height: 10,
          ),
          Consumer(builder: (context, ref, child) {
            final expState = ref.watch(expStateProvider.notifier);
            final inState = ref.watch(incomeStateNotifier.notifier);
            return TextButton(
              onPressed: () {
                t.detail = detailCtrl.text;
                t.amount = double.parse(
                    amountCtrl.text == '' ? '0.0' : amountCtrl.text);
                t.currency = ref.watch(currencyChangeNotifier).currency.name;
                if (t is Expense) {
                  (t as Expense).expCategory =
                      ref.watch(expCategoryChangeNotifier).expcategory.name;
                  if (t.detail != '' && t.amount > 0) {
                    expState.update(t as Expense);
                  }
                } else if (t is InCome) {
                  (t as InCome).inCategory =
                      ref.watch(inCategoryChangeNotifier).incategory.name;
                  if (t.detail != '' && t.amount > 0) {
                    inState.update(t as InCome);
                  }
                }
                if (t.detail != '' && t.amount > 0) {
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
                  "Update",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }),
        ]),
      ),
    );
  }
}
