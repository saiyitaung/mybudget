import 'package:mybudget/entities/budget.dart';
import './utils.dart';

class BudgetCalc<T extends Budget> {
  final List<T> data;
  BudgetCalc(this.data);
  double totalInMonth(int month, int year) {
    double total = 0.0;
    for (final d in getDataInMonth(month, year)) {
      total += d.amount;
    }
    return total;
  }

  List<T> getDataInMonth(int m, int y) {
    List<T> monthly = [];
    for (final d in data) {
      if (d.timeStamp.month == m && d.timeStamp.year == y) {
        monthly.add(d);
      }
    }
    return monthly;
  }
  double totalInDay(DateTime date){
    double total=0.0;
    for(final e in data){
      if(e.timeStamp.day == date.day && e.timeStamp.month == date.month && e.timeStamp.year == date.year){
        total += e.amount;
      }
    }
    return total;
  }
  double totalInWeek(DateTime d) {
    double total = 0.0;
    for (final d in getDataInWeek(d)) {
      total += d.amount;
    }
    return total;
  }

  List<T> getDataInWeek(DateTime d) {
    List<T> weekly = [];
    for (final v in data) {
      for (final date in dateInWeek(d)) {
        if (v.timeStamp.year != date.year) {
          continue;
        }
        if (v.timeStamp.month != date.month) {
          continue;
        }
        if (v.timeStamp.day == date.day) {
          weekly.add(v);
        }
      }
    }
    return weekly;
  }

  double totalInYear(int year) {
    double total = 0.0;
    for (final d in getDataInYear(year)) {
      total += d.amount;
    }
    return total;
  }

  List<T> getDataInYear(int y) {
    List<T> yearly = [];
    for (final d in data) {
      if (d.timeStamp.year == y) {
        yearly.add(d);
      }
    }
    return yearly;
  }
}