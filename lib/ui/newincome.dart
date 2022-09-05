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
      appBar: AppBar(title: const Text("New Income")),
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
                                child: Text(e.name.toString()),
                              ))
                          .toList(),
                      value: selected.currency,
                      selectedItemBuilder: ((context) => currencies.map((e) {
                            var textStyle = const TextStyle(color: Colors.white);
                            return Container(
                              padding: const EdgeInsets.only(
                                left: 20,
                              ),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                e.name,
                                style: textStyle,
                              ),
                            );
                          }).toList()),
                      onChanged: (c) {
                        selected.change(c!);
                        selectedCurrency = c;
                      });
                })),
              ),
            ]),
            Consumer(
              builder: (context, ref, child) {
                return InputTextWidget(
                  label: "Detail",
                  type: TextInputType.text,
                  ctl: detail,
                  autoCompleteText: ref
                      .watch(incomeStateNotifier)
                      .map((e) => e.detail)
                      .toList(),
                );
              },
            ),
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
            Consumer(builder: (context, ref, child) {
              selectedCategory = ref.watch(inCategoryChangeNotifier).incategory;
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
                      ).toSet()
                      .toList(),
                  value: ref.watch(inCategoryChangeNotifier).incategory,
                  onChanged: (v) {
                    selectedCategory = v!;
                    ref.read(inCategoryChangeNotifier).change(v);
                  });
            }),
            SizedBox(height: 10,),
            Consumer(builder: (context, ref, child) {
              final _incomeState = ref.watch(incomeStateNotifier.notifier);
              return TextButton(
                onPressed: () {
                  
                  var newItem = InCome(
                      id: const Uuid().v4(),
                      detail: detail.text,
                      amount: double.parse(amount.text == '' ? '0.0' : amount.text),
                      currency: selectedCurrency.name,
                      timeStamp: DateTime.now(),
                      inCategory: selectedCategory.name);                  
                  if (newItem.detail != '' && newItem.amount > 0) {
                    _incomeState.add(newItem);
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
