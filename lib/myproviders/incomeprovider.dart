import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:mybudget/entities/budgetcategory.dart';
import 'package:mybudget/entities/income.dart';

class IncomeStateNotifier extends StateNotifier<List<InCome>> {
  IncomeStateNotifier(super.state);
  add(InCome newItem) {
    incomebox.put(newItem.id, newItem);
    state = [...state, newItem];
  }
  void update(InCome obj){
    final index=state.indexOf(obj);
    state[index] = obj;
    state = [...state];
    incomebox.put(obj.id, obj);
  }
  remove(InCome item) {
    if (state.remove(item)) {
      incomebox.delete(item.id);     
    }
     state = [...state];
  }
}

final incomebox = Hive.box<InCome>("incomedb");
final incomeStateNotifier =
    StateNotifierProvider<IncomeStateNotifier, List<InCome>>(
        ((ref) => IncomeStateNotifier(incomebox.values.toList())));

class IncomeCategoryChangeNotifier extends ChangeNotifier {
  IncomeCategory incategory = IncomeCategory.salary;
  change(IncomeCategory e) {
    incategory = e;
    notifyListeners();
  }
}

final inCategoryChangeNotifier =
    ChangeNotifierProvider(((ref) => IncomeCategoryChangeNotifier()));
