import 'package:hive/hive.dart';
part 'budget.g.dart';
@HiveType(typeId: 1)
class Budget {
  @HiveField(0)
  String id;
  @HiveField(1)
  String detail;
  @HiveField(2)
  double amount;
  @HiveField(3)
  DateTime timeStamp;
  @HiveField(4)
  String currency;
  Budget(
      {required this.id,
      required this.detail,
      required this.amount,
      required this.timeStamp,
      required this.currency,
      });
}
