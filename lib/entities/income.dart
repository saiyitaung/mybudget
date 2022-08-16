 
import 'package:mybudget/entities/budget.dart';

class InCome extends Budget {
  String inCategory;
  InCome(
      {required super.id,
      required super.detail,
      required super.amount,
      required super.timeStamp,
      required super.currency,
      required this.inCategory,
      })
      : super();
}
