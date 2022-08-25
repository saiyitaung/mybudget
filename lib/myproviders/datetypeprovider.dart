import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DateType { day, week, month, year }

class DateTypeChangeNotifier extends StateNotifier<DateType> {
  DateTypeChangeNotifier(super.state);
  void change(DateType dt) {
    state = dt;
  }
}

final dateTypeChangeNotifierProvider =
    StateNotifierProvider<DateTypeChangeNotifier, DateType>(
        ((ref) => DateTypeChangeNotifier(DateType.week)));
class DateStateNotifier extends StateNotifier<DateTime>{
  DateStateNotifier(super.state);
}
final dateStateNotifier=StateNotifierProvider<DateStateNotifier,DateTime>(((ref) => DateStateNotifier(DateTime.now())));