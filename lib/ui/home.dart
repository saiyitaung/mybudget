
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mybudget/ui/expense.dart';
import 'package:mybudget/ui/income.dart';
import 'package:mybudget/ui/setting.dart';
import 'package:mybudget/widgets/bottomnav.dart';
import 'package:mybudget/widgets/cardwidget.dart';
import 'package:mybudget/widgets/mypiechart.dart';

class HomePage extends HookWidget {
  final navItems = const [
    Icon(Icons.home, color: Colors.white),
    Icon(
      Icons.arrow_circle_down_rounded,
      color: Colors.green,
    ),
    Icon(
      Icons.arrow_circle_up_rounded,
      color: Colors.red,
    ),
    Icon(
      Icons.settings,
      color: Colors.white,
    ),
  ];
  final pages = const [HomeViewUI(), IncomeUI(), ExpenseUI(), SettingUI()];

  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageCtrl = usePageController();
    // final tabCtrl =useTabController(initialLength: pages.length,initialIndex: 0);
    return Scaffold(
     
        body: PageView(
          
          children: pages,
          controller: pageCtrl,
         
          onPageChanged: (index) {
            
            pageCtrl.animateToPage(index,
                duration: const Duration(
                  milliseconds: 250,
                ),
                curve: Curves.bounceInOut);
          },
        ),
        bottomNavigationBar: BottomNav(
          pctrl: pageCtrl,
          items: navItems,
        ));
  }
}

class HomeViewUI extends ConsumerWidget {
  const HomeViewUI({Key? key}) : super(key: key);
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(children: [
        SizedBox(
          height: 160,
          width: double.infinity,
          child: Row(
            children: const [
              SizedBox(
                width: 15,
              ),
              Flexible(
                  flex: 1,
                  child: CardWidget(
                    title: "Income",
                    amount: 0,
                    color: Colors.green,
                  )),
              Flexible(
                  flex: 1,
                  child: CardWidget(
                    title: "Expense",
                    amount: 65000,
                    color: Color.fromARGB(255, 219, 50, 50),
                  )),
              SizedBox(
                width: 15,
              ),
            ],
          ),
        ),
        AspectRatio(
          aspectRatio: 1.8,
          child: Card(
            elevation: 0,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: MyPieChart(exP: 1800,inC: 1000,),
          ),
        ),
        Column(children: List.generate(10, (index) => ListTile(title: Text("$index"),)),),
      ]),
    );
  }
}
