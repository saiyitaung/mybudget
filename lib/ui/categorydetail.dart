import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mybudget/entities/budgetcategory.dart';
import 'package:mybudget/entities/expense.dart';
import 'package:mybudget/myproviders/currencychangeprovider.dart';
import 'package:mybudget/myproviders/datetypeprovider.dart';
import 'package:mybudget/myproviders/expstateprovider.dart';
import 'package:mybudget/utils/utils.dart';
import 'package:mybudget/widgets/budgetitem.dart';
import 'package:mybudget/widgets/categorydetaillinechart.dart';
import 'package:mybudget/widgets/mypiechart.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

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
          title: Text(
            title,
            style: TextStyle(fontFamily: "itim"),
          ),
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
                          : currencyString.currency.name[0].toUpperCase() +
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
    children.add(SizedBox(
      height: 10,
    ));
    children.add(
      CategoryDetailLineChartUI(
        gradientColors: const [Colors.red, Colors.redAccent],
        dateType: ref.watch(dateTypeChangeNotifierProvider),
        bardata: lineBarData,
      ),
    );
    children.add(SizedBox(
      height: 10,
    ));
    List<CategoryUsage> categoryUsage = [];
    double total = 0.0;
    totalByDetail(filteredExpense).forEach((key, value) {
      total += value;
      categoryUsage.add(CategoryUsage(key, value));
    });
    categoryUsage.sort((a, b) => b.amount.compareTo(a.amount));
    children.add(Container(
      child: Text("Common Usage",style: TextStyle(fontFamily: 'itim',fontSize: 22),),
      alignment: Alignment.center,
    ));
    children.addAll(categoryUsage
        .map((e) => ListTile(
              title: Padding(
                  child: Text(
                    "${e.category}",
                    style: TextStyle(fontFamily: 'itim', fontSize: 22),
                  ),
                  padding: EdgeInsets.only(left: 11)),
              trailing: Text("${getBalance(e.amount)}"),
              subtitle: LinearPercentIndicator(
                barRadius: Radius.circular(10),
                lineHeight: 14,
                center: Text("${((e.amount / total) * 100).toStringAsFixed(1)}%",style: TextStyle(color: Colors.black),),
                percent: e.amount / total,
                progressColor: Colors.redAccent,
              ),
            ))
        .toList());
        children.add(Divider());
    // children.add(MyPieChart(
    //   categoryUsage: categoryUsage,
    //   total: total,
    //   showIcon: false,
    // ));
    // filteredExpense.sort(((a, b) => b.timeStamp.compareTo(a.timeStamp)));
    // children.addAll(filteredExpense.map((e) => BudgetItem(
    //     icondata: expCategoryIcons[e.expCategory]!,
    //     iconbgColor: expCategoryColors[e.expCategory]!,
    //     title: e.detail,
    //     date: dateFmt(e.timeStamp),
    //     amount: getBalance(e.amount))));
    return children;
  }

  Map<String, double> totalByDetail(
    List<Expense> data,
  ) {
    final Map<String, double> detailUsage = {};
    for (final e in data) {
      detailUsage[e.detail] = (detailUsage[e.detail] ?? 0.0) + e.amount;
    }
    return detailUsage;
  }
}
