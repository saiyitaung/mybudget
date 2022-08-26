
import 'package:hive/hive.dart';
import 'package:mybudget/entities/budget.dart';

part 'expense.g.dart';
@HiveType(typeId: 3)
class Expense extends Budget {
  @HiveField(5)
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
