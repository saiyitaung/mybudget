import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:mybudget/entities/budgetcategory.dart';
import 'package:mybudget/entities/income.dart';

class IncomeStateNotifier extends StateNotifier<List<InCome>> {
  IncomeStateNotifier(super.state);
  add(InCome newItem) {
     incomebox.add(newItem);
    state = [...state, newItem];   
  }
}
final incomebox = Hive.box<InCome>("incomedb");
final incomeStateNotifier =
    StateNotifierProvider<IncomeStateNotifier, List<InCome>>(
        ((ref) => IncomeStateNotifier(incomebox.values.toList())));
class IncomeCategoryChangeNotifier extends ChangeNotifier{
  IncomeCategory incategory=IncomeCategory.salary;
  change(IncomeCategory e){
    incategory=e;
    notifyListeners();
  }
}
final inCategoryChangeNotifier=ChangeNotifierProvider(((ref) => IncomeCategoryChangeNotifier()));