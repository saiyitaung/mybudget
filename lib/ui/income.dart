import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mybudget/entities/income.dart';
import 'package:mybudget/myproviders/currencychangeprovider.dart';
import 'package:mybudget/myproviders/datetypeprovider.dart';
import 'package:mybudget/myproviders/incomeprovider.dart';
import 'package:mybudget/ui/edit.dart';
import 'package:mybudget/ui/newincome.dart';
import 'package:mybudget/utils/budgetcal.dart';
import 'package:mybudget/utils/utils.dart';
import 'package:mybudget/widgets/budgetitem.dart';
import 'package:mybudget/widgets/confirmdialog.dart';
import 'package:mybudget/widgets/datetoggleswitch.dart';
import 'package:mybudget/widgets/emptyusage.dart';
import 'package:mybudget/widgets/linechart.dart';
import 'package:toggle_switch/toggle_switch.dart';

class IncomeUI extends ConsumerWidget {
  const IncomeUI({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final incomes = ref.watch(incomeStateNotifier);
    final incomeBudgetCal =
        BudgetCalc(incomes, ref.watch(currencyChangeNotifier).currency);
    final selectedDate = ref.watch(dateStateNotifier);
    final currencyString = ref.watch(currencyChangeNotifier);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(" Income"),
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
                          fontFamily: "itim"),
                    )),
                    Container(
                        child: Row(
                      children: [
                        Text(
                          "${getBalance(getTotalBudget(incomeBudgetCal, ref.watch(dateTypeChangeNotifierProvider), selectedDate))}",
                          style: TextStyle(
                              fontFamily: "meriendaone",
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
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
                    )),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
              delegate:
                  SliverChildListDelegate(sliverChild(context, ref, incomes))),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => NewIncomeUI())));
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  List<Widget> sliverChild(
      BuildContext context, WidgetRef ref, List<InCome> incomes) {
    Map<double, double> lineBarData = {};
    switch (ref.watch(dateTypeChangeNotifierProvider)) {
      case DateType.week:
        lineBarData = weekLineBarData(
            ref.watch(incomeStateNotifier),
            ref.watch(dateStateNotifier),
            ref.watch(currencyChangeNotifier).currency);
        break;
      case DateType.month:
        lineBarData = monthLineBarData(
            ref.watch(incomeStateNotifier),
            ref.watch(dateStateNotifier),
            ref.watch(currencyChangeNotifier).currency);
        break;
      case DateType.year:
        lineBarData = yearLineBarData(
            ref.watch(incomeStateNotifier),
            ref.watch(dateStateNotifier),
            ref.watch(currencyChangeNotifier).currency);
        break;
      case DateType.day:
        break;
    }
    List<Widget> children = [];
    children.add(
      LineChartUI(
        gradientColors: [Colors.green, Colors.greenAccent],
        bardata: lineBarData,
        dateType: ref.watch(dateTypeChangeNotifierProvider),
      ),
    );
    children.add(
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
                                initialDate: ref.read(dateStateNotifier),
                                firstDate: DateTime(2021),
                                lastDate: DateTime.now())
                            .then((value) {
                          if (value != null) {
                            ref.read(dateStateNotifier.notifier).state = value;
                          }
                        });
                      },
                      icon: Icon(Icons.calendar_month),
                      padding: EdgeInsets.only(bottom: 2),
                    ),
                    DateToggle(
                        selectedDateType:
                            ref.watch(dateTypeChangeNotifierProvider))
                  ],
                )),
          ],
        ),
      ),
    );
    List<InCome> inList = [];
    final date = ref.watch(dateStateNotifier);
    final incomeBudgetCal =
        BudgetCalc(incomes, ref.watch(currencyChangeNotifier).currency);
    switch (ref.watch(dateTypeChangeNotifierProvider)) {
      case DateType.week:
        inList = incomeBudgetCal.getDataInWeek(date);
        break;
      case DateType.month:
        inList = incomeBudgetCal.getDataInMonth(date.month, date.year);
        break;
      case DateType.year:
        inList = incomeBudgetCal.getDataInYear(date.year);
        break;
      default:
        break;
    }
    inList.sort(((a, b) => b.timeStamp.compareTo(a.timeStamp)));
    inList.isEmpty
        ? children.add(EmptyInfoUI())
        : children.addAll(
            inList.map(
              (e) => Slidable(
                endActionPane: ActionPane(
                  extentRatio: .3,
                  children: [
                    SlidableAction(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      onPressed: (context) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Edit<InCome>(t: e),
                            ));
                      },
                      icon: Icons.edit,
                      foregroundColor: Colors.green,
                    ),
                    SlidableAction(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      onPressed: (context) {
                        showDialog(context: context, builder: (context) => ConfirmDialog()).then((value) {
                          if(value != null && value){
                            ref.watch(incomeStateNotifier.notifier).remove(e);
                          }
                        });
                      },
                      foregroundColor: Colors.red,
                      icon: Icons.delete_forever_sharp,
                    ),
                  ],
                  motion: const ScrollMotion(),
                ),
                child: BudgetItem(
                    icondata: inCategoryIcons[e.inCategory]!,
                    iconbgColor: Colors.green,
                    title: e.detail,
                    date: dateFmt(e.timeStamp),
                    amount: getBalance(e.amount)),
              ),
            ),
          );
    return children;
  }
}
