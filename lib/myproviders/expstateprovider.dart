import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mybudget/entities/expense.dart';

final expStateProvider = StateNotifierProvider<ExpProvider,List<Expense>>(((ref) => ExpProvider([])));

class ExpProvider extends StateNotifier<List<Expense>> {
  ExpProvider(super.state);   
  add(Expense e) {
    state = [...state, e];        
  }   
}
