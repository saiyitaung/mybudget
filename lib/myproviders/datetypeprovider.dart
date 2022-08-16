import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DateType { day, week, month, year }

class DateTypeChangeNotifier extends ChangeNotifier {
  DateType dateType = DateType.year;
  void change(DateType dt){
    dateType=dt;
    notifyListeners();
  }
}
final dateTypeChangeNotifierProvider =
    ChangeNotifierProvider<DateTypeChangeNotifier>(
        ((ref) => DateTypeChangeNotifier()));
