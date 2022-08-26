import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:mybudget/entities/expense.dart';

final expenseBox = Hive.box<Expense>("expensedb");
final expStateProvider = StateNotifierProvider<ExpProvider, List<Expense>>(
    ((ref) => ExpProvider(expenseBox.values.toList())));

class ExpProvider extends StateNotifier<List<Expense>> {
  ExpProvider(super.state);
  add(Expense e) {
    expenseBox.values.forEach((element) {
      print("$element");
    });
    expenseBox.add(e);
    state = [...state, e];
  }
}
