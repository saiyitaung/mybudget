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
    return Scaffold(
      backgroundColor: Color(0xff232d37),
      body: CustomScrollView(slivers: [
        SliverAppBar(
          title: Text(title),
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
            filteredExpense, ref.watch(dateStateNotifier),ref.watch(currencyChangeNotifier).currency);
        break;
      case DateType.month:
        lineBarData = monthLineBarData(
            ref.watch(expStateProvider), ref.watch(dateStateNotifier),ref.watch(currencyChangeNotifier).currency);
        break;
      case DateType.year:
        lineBarData = yearLineBarData(
            ref.watch(expStateProvider), ref.watch(dateStateNotifier),ref.watch(currencyChangeNotifier).currency);
        break;
      case DateType.day:
        break;
    }
    List<Widget> children = [];
    children.add(
      Container(
        padding: EdgeInsets.only(top:10),
        width: double.infinity,
        alignment: Alignment.center,
        color: Color(0xff232d37),
        child: Text("Total Usage : ${getBalance(totalExp(filteredExpense))}"),
        
      ),
    );
    children.add(
      CategoryDetailLineChartUI(
        gradientColors: [Colors.red, Colors.redAccent],
        dateType: ref.watch(dateTypeChangeNotifierProvider),
        bardata: lineBarData,
      ),
    );
    children.addAll(filteredExpense.map((e) => BudgetItem(
        icondata: expCategoryIcons[e.expCategory]!,
        iconbgColor: expCategoryColors[e.expCategory]!,
        title: e.detail,
        date: dateFmt(e.timeStamp),
        amount: getBalance(e.amount))));
    return children;
  }
}
