import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mybudget/entities/budgetcategory.dart';

class ExpCategoryChangeNotifier extends ChangeNotifier{
  ExpenseCategory expcategory=ExpenseCategory.foodanddrink;
  change(ExpenseCategory e){
    expcategory=e;
    notifyListeners();
  }
}
final expCategoryChangeNotifier=ChangeNotifierProvider(((ref) => ExpCategoryChangeNotifier()));