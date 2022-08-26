import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mybudget/entities/budgetcategory.dart';
import 'package:mybudget/entities/expense.dart';
import 'package:mybudget/myproviders/currencychangeprovider.dart';
import 'package:mybudget/myproviders/datetypeprovider.dart';
import 'package:mybudget/myproviders/expstateprovider.dart';
import 'package:mybudget/myproviders/incomeprovider.dart';
import 'package:mybudget/ui/categorydetail.dart';
import 'package:mybudget/ui/expense.dart';
import 'package:mybudget/ui/income.dart';
import 'package:mybudget/ui/setting.dart';
import 'package:mybudget/utils/budgetcal.dart';
import 'package:mybudget/utils/utils.dart';
import 'package:mybudget/widgets/budgetitem.dart';
import 'package:mybudget/widgets/cardwidget.dart';
import 'package:mybudget/widgets/categoryicon.dart';
import 'package:mybudget/widgets/datetoggleswitch.dart';
import 'package:mybudget/widgets/emptyusage.dart';
import 'package:mybudget/widgets/mypiechart.dart';
import 'package:toggle_switch/toggle_switch.dart';

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeViewUI(),
    );
  }
}

class HomeViewUI extends ConsumerWidget {
  const HomeViewUI({Key? key}) : super(key: key);
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDateType = ref.watch(dateTypeChangeNotifierProvider);
    final selectedDate = ref.watch(dateStateNotifier);
    final exps = ref.watch(expStateProvider);
    var categoryCalc = totalByCategory(exps, selectedDateType, selectedDate,
        ref.watch(currencyChangeNotifier).currency);
    categoryCalc.forEach((k, v) {
      if (v > 0) {
        debugPrint("$k : $v");
      }
    });
    return CustomScrollView(slivers: [
      SliverList(delegate: SliverChildListDelegate(getSliverList(context, ref)))
    ]);
  }

  List<Widget> getSliverList(BuildContext context, WidgetRef ref) {
    final incomeBudgetCalc = BudgetCalc(ref.watch(incomeStateNotifier),
        ref.watch(currencyChangeNotifier).currency);
    final expBudgetCalc = BudgetCalc(ref.watch(expStateProvider),
        ref.watch(currencyChangeNotifier).currency);
    final date = ref.watch(dateStateNotifier);
    double totalExpense = getTotalBudget(
        expBudgetCalc, ref.watch(dateTypeChangeNotifierProvider), date);
    double totalIncome = getTotalBudget(
        incomeBudgetCalc, ref.watch(dateTypeChangeNotifierProvider), date);
    List<Widget> children = [];
    children.add(
      Container(
        margin: EdgeInsets.only(top: 25),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Text(
              "Sai Yi",
              style: TextStyle(
                  fontFamily: 'Itim',
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => SettingUI())));
              },
              child: Hero(
                tag: "p",
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("img/profile.png"))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    children.add(
      SizedBox(
        height: 120,
        width: double.infinity,
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Flexible(
              flex: 1,
              child: InkWell(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => IncomeUI())),
                  child: Stack(
                    children: [
                      Center(
                        child: CardWidget(
                          title: "Income",
                          amount: "$totalIncome",
                          color: Colors.green,
                        ),
                      ),
                      Positioned(
                        child: Icon(Icons.arrow_circle_down,color: Colors.white70),
                        top: 15,
                        left: 15,
                      ),
                    ],
                  )),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              flex: 1,
              child: InkWell(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ExpenseUI())),
                  child: Stack(
                    children: [
                      Center(
                        child: CardWidget(
                          title: "Expense",
                          amount: "${getBalance(totalExpense)}",
                          color: Colors.red,
                        ),
                      ),
                      Positioned(
                        child: Icon(Icons.arrow_circle_up,color: Colors.white70,),
                        top: 15,
                        left: 15,
                      ),
                    ],
                  )),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
    children.add(
      SizedBox(
        height: 10,
      ),
    );
    children.add(
      Container(
        height: 60,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text("Overall expense"),
          Container(
              height: 30,
              child: DateToggle(
                selectedDateType: ref.watch(dateTypeChangeNotifierProvider),
              )),
        ]),
      ),
    );
    children.add(
      SizedBox(
        height: 10,
      ),
    );
    List<CategoryUsage> listCategoryUsage = [];
    totalByCategory(
            ref.watch(expStateProvider),
            ref.watch(dateTypeChangeNotifierProvider),
            ref.watch(dateStateNotifier),
            ref.watch(currencyChangeNotifier).currency)
        .forEach((key, value) {
      if (value > 0) {
        listCategoryUsage.add(CategoryUsage(key, value));
      }
    });
    listCategoryUsage.sort(((a, b) => b.amount.compareTo(a.amount)));

    children.add(
      MyPieChart(
        categoryUsage: listCategoryUsage,
        total: totalExp(ref.read(expStateProvider)),
      ),
    );
    listCategoryUsage.isEmpty
        ? children.add(EmptyInfoUI())
        : children.addAll(listCategoryUsage.map((e) => InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryDetailUI(
                          filteredExpense: filterByCategory(
                              ref.watch(expStateProvider),
                              e.category,
                              ref.watch(currencyChangeNotifier).currency.name),
                          title: categoriesString[e.category]!),
                    ));
              },
              child: BudgetItem(
                icondata: expCategoryIcons[e.category]!,
                iconbgColor: expCategoryColors[e.category]!,
                amount: getBalance(e.amount),
                date: '',
                showSub: false,
                title: e.category,
              ),
            )));
    return children;
  }

  List<Expense> filterByCategory(
      List<Expense> data, String category, String currency) {
    List<Expense> filteredCategory = [];
    for (final e in data) {
      if (e.expCategory == category && e.currency == currency) {
        filteredCategory.add(e);
      }
    }
    filteredCategory.sort((a, b) => a.timeStamp.compareTo(b.timeStamp));
    return filteredCategory;
  }

  Map<String, double> totalByCategory(
      List<Expense> data, DateType dt, DateTime date, Currency currency) {
    final Map<String, double> totalInCategory = {
      ExpenseCategory.foodanddrink.name: 0.0,
      ExpenseCategory.health.name: 0.0,
      ExpenseCategory.accessories.name: 0.0,
      ExpenseCategory.bill.name: 0.0,
      ExpenseCategory.transportation.name: 0.0,
      ExpenseCategory.clothing.name: 0.0,
      ExpenseCategory.other.name: 0.0,
    };
    final _exps = BudgetCalc(data, currency);
    switch (dt) {
      case DateType.week:
        for (final e in _exps.getDataInWeek(date)) {
          totalInCategory[e.expCategory] =
              totalInCategory[e.expCategory]! + e.amount;
        }
        break;
      case DateType.month:
        for (final e in _exps.getDataInMonth(date.month, date.year)) {
          totalInCategory[e.expCategory] =
              totalInCategory[e.expCategory]! + e.amount;
        }
        break;
      case DateType.year:
        for (final e in _exps.getDataInYear(date.year)) {
          totalInCategory[e.expCategory] =
              totalInCategory[e.expCategory]! + e.amount;
        }
        break;
      default:
        break;
    }
    return totalInCategory;
  }
}
