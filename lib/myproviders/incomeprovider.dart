import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mybudget/entities/budgetcategory.dart';
import 'package:mybudget/entities/income.dart';

class IncomeStateNotifier extends StateNotifier<List<InCome>> {
  IncomeStateNotifier(super.state);
  add(InCome newItem) {
    state = [...state, newItem];
  }
}

final incomeStateNotifier =
    StateNotifierProvider<IncomeStateNotifier, List<InCome>>(
        ((ref) => IncomeStateNotifier([])));
class IncomeCategoryChangeNotifier extends ChangeNotifier{
  IncomeCategory incategory=IncomeCategory.salary;
  change(IncomeCategory e){
    incategory=e;
    notifyListeners();
  }
}
final inCategoryChangeNotifier=ChangeNotifierProvider(((ref) => IncomeCategoryChangeNotifier()));