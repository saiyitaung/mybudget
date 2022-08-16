
import 'package:mybudget/entities/budget.dart';

class Expense extends Budget {
  String expCategory;
  Expense(
      {required super.id,
      required super.detail,
      required super.amount,
      required super.timeStamp,
      required super.currency,
      required this.expCategory
      })
      : super();
}
