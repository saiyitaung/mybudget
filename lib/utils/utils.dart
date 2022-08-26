import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mybudget/entities/budget.dart';
import 'package:mybudget/entities/budgetcategory.dart';
import 'package:mybudget/entities/expense.dart';
import 'package:mybudget/myproviders/currencychangeprovider.dart';
import 'package:mybudget/myproviders/datetypeprovider.dart';
import 'package:mybudget/utils/budgetcal.dart';

//const list of expense category
//for dropdown choice and other
final expCategories = [
  ExpenseCategory.foodanddrink,
  ExpenseCategory.health,
  ExpenseCategory.accessories,
  ExpenseCategory.bill,
  ExpenseCategory.transportation,
  ExpenseCategory.clothing,
  ExpenseCategory.other
];
//Map of
final Map<String, String> categoriesString = {
  ExpenseCategory.foodanddrink.name: "Food and Drinks",
  ExpenseCategory.health.name: "Health",
  ExpenseCategory.accessories.name: "Accessories",
  ExpenseCategory.bill.name: "Bill",
  ExpenseCategory.transportation.name: "Transportation",
  ExpenseCategory.clothing.name: "Clothing",
  ExpenseCategory.other.name: "Other"
};
final Map<String, Color> expCategoryColors = {
  ExpenseCategory.foodanddrink.name: Colors.blue,
  ExpenseCategory.health.name: Colors.orangeAccent,
  ExpenseCategory.accessories.name: Colors.indigo,
  ExpenseCategory.bill.name: Colors.green,
  ExpenseCategory.transportation.name: Colors.cyan,
  ExpenseCategory.clothing.name: Colors.purple,
  ExpenseCategory.other.name: Colors.pink
};
final Map<String, IconData> expCategoryIcons = {
  ExpenseCategory.foodanddrink.name: Icons.fastfood_rounded,
  ExpenseCategory.health.name: FontAwesomeIcons.briefcaseMedical,
  ExpenseCategory.accessories.name: Icons.devices_other,
  ExpenseCategory.bill.name: FontAwesomeIcons.moneyCheckDollar,
  ExpenseCategory.transportation.name: FontAwesomeIcons.bus,
  ExpenseCategory.clothing.name: FontAwesomeIcons.shopify,
  ExpenseCategory.other.name: FontAwesomeIcons.question
};
final inCategories = [
  IncomeCategory.salary,
  IncomeCategory.service,
  IncomeCategory.soldProperty
];
final Map<String, IconData> inCategoryIcons = {
  IncomeCategory.salary.name: FontAwesomeIcons.userTie,
  IncomeCategory.service.name: FontAwesomeIcons.screwdriverWrench,
  IncomeCategory.soldProperty.name: FontAwesomeIcons.arrowsRotate
};
// dateFmt for formate date day/month/year
String dateFmt(DateTime d) {
  return "${d.day}/${d.month}/${d.year}";
}

//totalExp
//get total amount in the list of Expense
double totalExp(List<Expense> data) {
  double total = 0.0;
  for (final e in data) {
    total += e.amount;
  }
  return total;
}

//getDayInMonth return how many days in a month
int getDayInMonth(int month, int year) {
  int days = 0;
  switch (month) {
    case 1:
      days = 31;
      break;
    case 2:
      if (year % 4 == 0) {
        days = 29;
      } else {
        days = 28;
      }
      break;
    case 3:
      days = 31;
      break;
    case 4:
      days = 30;
      break;
    case 5:
      days = 31;
      break;
    case 6:
      days = 30;
      break;
    case 7:
      days = 31;
      break;
    case 8:
      days = 31;
      break;
    case 9:
      days = 30;
      break;
    case 10:
      days = 31;
      break;
    case 11:
      days = 30;
      break;
    case 12:
      days = 31;
      break;
  }
  return days;
}

//getInititalIndex return DateType index for button toggle
int getInititalIndex(DateType dt) {
  switch (dt) {
    case DateType.week:
      return 0;
    case DateType.month:
      return 1;
    case DateType.year:
      return 2;
    default:
      return 0;
  }
}

//weekLineBarData return Map<double,double> for chart in a week
//example {0:1000,1:2000,2:3000}
Map<double, double> weekLineBarData(
    List<Budget> data, DateTime date, Currency currency) {
  final Map<double, double> weeklyData = {};
  double index = 0;
  final budgetCal = BudgetCalc(data, currency);
  for (final d in dateInWeek(date)) {
    weeklyData[index] = budgetCal.totalInDay(d);
    index++;
  }
  return weeklyData;
}
//weekLineBarData return Map<double,double> for chart in a month
//example {0:1000,1:2000,2:3000}
Map<double, double> monthLineBarData(
    List<Budget> data, DateTime date, Currency currency) {
  final Map<double, double> monthData = {};
  final budgetCal = BudgetCalc(data, currency);
  double index = 0;
  for (int day = 1; day < getDayInMonth(date.month, date.year); day++) {
    monthData[index] =
        budgetCal.totalInDay(DateTime(date.year, date.month, day));
    index++;
  }
  return monthData;
}
//weekLineBarData return Map<double,double> for chart in a year
//example {0:1000,1:2000,2:3000}
Map<double, double> yearLineBarData(
    List<Budget> data, DateTime date, Currency currency) {
  final Map<double, double> yearData = {};
  final budgetCal = BudgetCalc(data, currency);
  double index = 0;
  for (int month = 1; month <= 12; month++) {
    yearData[index] = budgetCal.totalInMonth(month, date.year);
    index++;
  }
  return yearData;
}
/*getBalance  return String for balance
if balance is large amount
*/
String getBalance(double amount) {
  if (amount > 1000000 && amount < 1000000000) {
    return "${(amount / 1000000).toStringAsFixed(3)} M";
  } else if (amount > 1000000000 && amount < 1000000000000) {
    return "${(amount / 1000000000).toStringAsFixed(3)}B";
  } else if (amount > 1000000000000 && amount < 1000000000000000) {
    return "${(amount / 1000000000).toStringAsFixed(3)}T";
  } else {
    return "$amount";
  }
}
//getTotalBudget 
//return total balance in (week,month,year)
double getTotalBudget(BudgetCalc budgetCalc, DateType dt, DateTime date) {
  double total = 0.0;
  switch (dt) {
    case DateType.week:
      total = budgetCalc.totalInWeek(date);
      break;
    case DateType.month:
      total = budgetCalc.totalInMonth(date.month, date.year);
      break;
    case DateType.year:
      total = budgetCalc.totalInYear(date.year);
      break;
    case DateType.day:
      break;
  }
  return total;
}
//dateInWeek
//return list of date in a week choose by d (argument)
List<DateTime> dateInWeek(DateTime d) {
  List<DateTime> week = [];
  switch (d.weekday) {
    case 1:
      week.add(DateTime(d.year, d.month, d.day - 1));
      for (int i = 0; i < 6; i++) {
        week.add(DateTime(d.year, d.month, d.day + i));
      }
      break;
    case 2:
      for (int sub = 2; sub > 0; sub--) {
        week.add(DateTime(d.year, d.month, d.day - sub));
      }
      for (int i = 0; i < 5; i++) {
        week.add(DateTime(d.year, d.month, d.day + i));
      }

      break;
    case 3:
      for (int sub = 3; sub > 0; sub--) {
        week.add(DateTime(d.year, d.month, d.day - sub));
      }
      for (int i = 0; i < 4; i++) {
        week.add(DateTime(d.year, d.month, d.day + i));
      }

      break;
    case 4:
      for (int sub = 4; sub > 0; sub--) {
        week.add(DateTime(d.year, d.month, d.day - sub));
      }
      for (int i = 0; i < 3; i++) {
        week.add(DateTime(d.year, d.month, d.day + i));
      }

      break;
    case 5:
      for (int sub = 5; sub > 0; sub--) {
        week.add(DateTime(d.year, d.month, d.day - sub));
      }
      for (int i = 0; i < 2; i++) {
        week.add(DateTime(d.year, d.month, d.day + i));
      }

      break;
    case 6:
      for (int i = 6; i >= 0; i--) {
        week.add(DateTime(d.year, d.month, d.day - i));
      }
      break;
    case 7:
      for (int i = 0; i < 7; i++) {
        week.add(DateTime(d.year, d.month, d.day + i));
      }
      break;
  }
  return week;
}
//yearBottomTitleWidgets
//return Title widget for chart
Widget yearBottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
      color: Color(0xff68737d),
      fontSize: 16,
      fontFamily: "Itim",
      fontWeight: FontWeight.bold);
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text(
        "Jan",
        style: style,
      );
      break;
    case 1:
      text = const Text(
        "Feb",
        style: style,
      );
      break;
    case 2:
      text = const Text(
        "Mar",
        style: style,
      );
      break;
    case 3:
      text = const Text(
        "Apr",
        style: style,
      );
      break;
    case 4:
      text = const Text(
        "May",
        style: style,
      );
      break;
    case 5:
      text = const Text(
        "Jun",
        style: style,
      );
      break;
    case 6:
      text = const Text(
        "Jul",
        style: style,
      );
      break;
    case 7:
      text = const Text(
        "Aug",
        style: style,
      );
      break;
    case 8:
      text = const Text(
        "Sep",
        style: style,
      );
      break;
    case 9:
      text = const Text(
        "Oct",
        style: style,
      );
      break;
    case 10:
      text = const Text(
        "Nov",
        style: style,
      );
      break;
    case 11:
      text = const Text(
        "Dec",
        style: style,
      );
      break;
    default:
      text = const Text('');
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 3.0,
    angle: -45.0,
    child: text,
  );
}

Widget monthBottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
      color: Color(0xff68737d),
      fontSize: 16,
      fontFamily: "Itim",
      fontWeight: FontWeight.bold);
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text(
        "1",
        style: style,
      );
      break;
    case 4:
      text = const Text(
        "5",
        style: style,
      );
      break;
    case 9:
      text = const Text(
        "10",
        style: style,
      );
      break;
    case 14:
      text = const Text(
        "15",
        style: style,
      );
      break;
    case 19:
      text = const Text(
        "20",
        style: style,
      );
      break;
    case 24:
      text = const Text(
        "25",
        style: style,
      );
      break;
    case 29:
      text = const Text(
        "30",
        style: style,
      );
      break;
    default:
      text = const Text('');
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 2.0,
    child: text,
  );
}

Widget weekbottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
      color: Color(0xff68737d),
      fontSize: 16,
      fontFamily: "Itim",
      fontWeight: FontWeight.bold);
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text(
        'Sun',
        style: style,
      );
      break;
    case 1:
      text = const Text('Mon', style: style);
      break;
    case 2:
      text = const Text('Tue', style: style);
      break;
    case 3:
      text = const Text('Wed', style: style);
      break;
    case 4:
      text = const Text('Thu', style: style);
      break;
    case 5:
      text = const Text('Fri', style: style);
      break;
    case 6:
      text = const Text('Sat', style: style);
      break;
    default:
      text = const Text(
        '',
        style: style,
      );
      break;
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 3.0,
    child: text,
  );
}
