import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mybudget/entities/expense.dart';
import 'package:mybudget/myproviders/currencychangeprovider.dart';
import 'package:mybudget/myproviders/datetypeprovider.dart';
import 'package:mybudget/myproviders/expstateprovider.dart';
import 'package:mybudget/utils/utils.dart';
import 'package:mybudget/widgets/budgetitem.dart';
import 'package:mybudget/widgets/categorydetaillinechart.dart';

class CategoryDetailUI extends ConsumerWidget {
  final String title;
  final List<Expense> filteredExpense;
  const CategoryDetailUI(
      {Key? key, required this.title, required this.filteredExpense})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currencyString = ref.watch(currencyChangeNotifier);
    return Scaffold(
      backgroundColor: Color(0xff232d37),
      body: CustomScrollView(slivers: [
        SliverAppBar(
          title: Text(" Expense"),
          backgroundColor: Color(0xff232d37),
          pinned: true,
          expandedHeight: 120,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      child: Text(
                    "Total ",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Itim"),
                  )),
                  Container(
                      child: Row(
                    children: [
                      Text(
                        " ${getBalance(totalExp(filteredExpense))}",
                        style: TextStyle(
                            fontFamily: "meriendaone",
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
                     Container(
                          padding: EdgeInsets.only(top: 12, left: 5),
                          child: Text(
                            // utils.currenciesString[selectedCurrency!]!,
                            currencyString.currency.name == "mmk"
                                ? currencyString.currency.name.toUpperCase()
                                : currencyString.currency.name[0]
                                        .toUpperCase() +
                                    currencyString.currency.name.substring(1),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white54,
                              fontFamily: "meriendaone",
                            ),
                          ),
                     ),
                ],
              ),
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate(getSliverList(context, ref)))
      ]),
    );
  }

  List<Widget> getSliverList(BuildContext context, WidgetRef ref) {
    Map<double, double> lineBarData = {};
    switch (ref.watch(dateTypeChangeNotifierProvider)) {
      case DateType.week:
        lineBarData = weekLineBarData(
            filteredExpense,
            ref.watch(dateStateNotifier),
            ref.watch(currencyChangeNotifier).currency);
        break;
      case DateType.month:
        lineBarData = monthLineBarData(
            filteredExpense,
            ref.watch(dateStateNotifier),
            ref.watch(currencyChangeNotifier).currency);
        break;
      case DateType.year:
        lineBarData = yearLineBarData(
            filteredExpense,
            ref.watch(dateStateNotifier),
            ref.watch(currencyChangeNotifier).currency);
        break;
      case DateType.day:
        break;
    }
    List<Widget> children = [];

    children.add(
      CategoryDetailLineChartUI(
        gradientColors: const [Colors.red, Colors.redAccent],
        dateType: ref.watch(dateTypeChangeNotifierProvider),
        bardata: lineBarData,
      ),
    );
    filteredExpense.sort(((a, b) => b.timeStamp.compareTo(a.timeStamp)));
    children.addAll(filteredExpense.map((e) => BudgetItem(
        icondata: expCategoryIcons[e.expCategory]!,
        iconbgColor: expCategoryColors[e.expCategory]!,
        title: e.detail,
        date: dateFmt(e.timeStamp),
        amount: getBalance(e.amount))));
    return children;
  }
}
