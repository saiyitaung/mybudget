import 'package:hive/hive.dart';
import 'package:mybudget/entities/budget.dart';
part 'income.g.dart';
@HiveType(typeId: 2)
class InCome extends Budget {
  @HiveField(5)
  String inCategory;
  InCome({
    required super.id,
    required super.detail,
    required super.amount,
    required super.timeStamp,
    required super.currency,
    required this.inCategory,
  }) : super();
}
