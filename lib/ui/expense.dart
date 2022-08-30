import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mybudget/entities/expense.dart';
import 'package:mybudget/myproviders/currencychangeprovider.dart';
import 'package:mybudget/myproviders/datetypeprovider.dart';
import 'package:mybudget/myproviders/expstateprovider.dart';
import 'package:mybudget/ui/categorydetail.dart';
import 'package:mybudget/ui/edit.dart';
import 'package:mybudget/ui/newexp.dart';
import 'package:mybudget/utils/budgetcal.dart';
import 'package:mybudget/utils/utils.dart';
import 'package:mybudget/widgets/budgetitem.dart';
import 'package:mybudget/widgets/datetoggleswitch.dart';
import 'package:mybudget/widgets/emptyusage.dart';
import 'package:mybudget/widgets/linechart.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ExpenseUI extends ConsumerWidget {
  const ExpenseUI({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exps = ref.watch(expStateProvider);
    final selectedDateType = ref.watch(dateTypeChangeNotifierProvider);
    final selectedDate = ref.watch(dateStateNotifier);
    final budgetCalc =
        BudgetCalc<Expense>(exps, ref.watch(currencyChangeNotifier).currency);
    final total = getTotalBudget(budgetCalc, selectedDateType, selectedDate);
    debugPrint("rebuild $selectedDateType");
    return Scaffold(
      body: CustomScrollView(
        slivers: [
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
                          " ${getBalance(getTotalBudget(budgetCalc, selectedDateType, selectedDate))}",
                          style: TextStyle(
                              fontFamily: "meriendaone",
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        // Container(
                        //   padding: EdgeInsets.only(top: 5, left: 5),
                        //   child: Text(
                        //     // utils.currenciesString[selectedCurrency!]!,
                        //     getCurrencysLocale(context, selectedCurrency!),
                        //     style: TextStyle(
                        //       fontSize: 12,
                        //       color: Colors.white54,
                        //       fontFamily: "meriendaone",
                        //     ),
                        //   ),
                        // ),
                      ],
                    )),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate(
                  sliverChild(context, ref, selectedDateType, exps))),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(.7),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: ((context) => NewExpUI())));
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  List<Widget> sliverChild(BuildContext context, WidgetRef ref,
      DateType selectedDateType, List<Expense> exps) {
    Map<double, double> lineBarData = {};
    final budgetCal =
        BudgetCalc<Expense>(exps, ref.watch(currencyChangeNotifier).currency);
    debugPrint("total week : ${budgetCal.totalInWeek(DateTime.now())}");
    List<Widget> childs = [];
    debugPrint("${selectedDateType}");
    switch (selectedDateType) {
      case DateType.week:
        lineBarData = weekLineBarData(
            ref.watch(expStateProvider),
            ref.watch(dateStateNotifier),
            ref.watch(currencyChangeNotifier).currency);
        break;
      case DateType.month:
        lineBarData = monthLineBarData(
            ref.watch(expStateProvider),
            ref.watch(dateStateNotifier),
            ref.watch(currencyChangeNotifier).currency);
        break;
      case DateType.year:
        lineBarData = yearLineBarData(
            ref.watch(expStateProvider),
            ref.watch(dateStateNotifier),
            ref.watch(currencyChangeNotifier).currency);
        break;
      case DateType.day:
        break;
    }
    childs.add(
      LineChartUI(
        gradientColors: [Colors.red, Colors.redAccent],
        dateType: selectedDateType,
        bardata: lineBarData,
      ),
    );
    childs.add(
      Container(
        height: 60,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(
                "Activities",
                style: TextStyle(fontFamily: "itim", fontSize: 28),
              ),
              padding: EdgeInsets.only(left: 20),
            ),
            Container(
                height: 30,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                builder: ((context, child) => Theme(
                                    data: ThemeData.dark(), child: child!)),
                                initialDate: ref.watch(dateStateNotifier),
                                firstDate: DateTime(2021),
                                lastDate: DateTime.now())
                            .then((value) {
                          if (value != null) {
                            ref.watch(dateStateNotifier.notifier).state = value;
                          }
                        });
                      },
                      icon: Icon(Icons.calendar_month),
                      padding: EdgeInsets.only(bottom: 2),
                    ),
                    DateToggle(selectedDateType: selectedDateType)
                  ],
                )),
          ],
        ),
      ),
    );
    List<Expense> expList = [];
    final date = ref.watch(dateStateNotifier);
    switch (selectedDateType) {
      case DateType.week:
        expList = budgetCal.getDataInWeek(date);
        break;
      case DateType.month:
        expList = budgetCal.getDataInMonth(date.month, date.year);
        break;
      case DateType.year:
        expList = budgetCal.getDataInYear(date.year);
        break;
      default:
        break;
    }
    expList.sort(((a, b) => b.timeStamp.compareTo(a.timeStamp)));
    exps.isEmpty
        ? childs.add(EmptyInfoUI())
        : childs.addAll(
            expList.map(
              (e) => Slidable(
                endActionPane: ActionPane(
                  extentRatio: .3,
                  children: [
                    SlidableAction(
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      onPressed: (context) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Edit<Expense>(t: e),));
                      },
                      icon: Icons.edit,
                      foregroundColor: Colors.green,
                    ),
                    SlidableAction(
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      onPressed: (context) {
                        ref.watch(expStateProvider.notifier).remove(e);
                      },
                      foregroundColor: Colors.red,
                      icon: Icons.delete_forever_sharp,
                    ),
                  ],
                  motion: const ScrollMotion(),
                ),
                child: BudgetItem(
                  icondata: expCategoryIcons[e.expCategory]!,
                  iconbgColor: expCategoryColors[e.expCategory]!,
                  title: e.detail,
                  date: dateFmt(e.timeStamp),
                  amount: getBalance(e.amount),
                ),
              ),
            ),
          );
    return childs;
  }
}
