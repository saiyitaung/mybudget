import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:mybudget/entities/expense.dart';

final expenseBox = Hive.box<Expense>("expensedb");
final expStateProvider = StateNotifierProvider<ExpProvider, List<Expense>>(
    ((ref) => ExpProvider(expenseBox.values.toList())));

class ExpProvider extends StateNotifier<List<Expense>> {
  ExpProvider(super.state);
  add(Expense e) {    
    expenseBox.put(e.id, e);
    state = [...state, e];
  }
  void update(Expense e){
    var index=state.indexOf(e);
    state[index]=e;
    state = [...state];
    expenseBox.put(e.id, e);
  }
  remove(Expense e){
    if(state.remove(e)){
      expenseBox.delete(e.id);
    }
    state = [...state];
  }
}
