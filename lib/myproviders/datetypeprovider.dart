import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:mybudget/myproviders/settingprovider.dart';

enum DateType { day, week, month, year }

final Map<String, DateType> strDateType = {
  DateType.week.name: DateType.week,
  DateType.month.name: DateType.month,
  DateType.year.name: DateType.year,
};
final settingBox = Hive.box<String>("settingdb");

class DateTypeChangeNotifier extends StateNotifier<DateType> {
  DateTypeChangeNotifier(super.state);
  void change(DateType dt)async {
    state = dt;
    await settingBox.put("defaultDateType", dt.name);
  }
}

final dateTypeChangeNotifierProvider =
    StateNotifierProvider<DateTypeChangeNotifier, DateType>(
        ((ref) => DateTypeChangeNotifier(strDateType[settingBox.get('defaultDateType') ?? "month"]!)));

class DateStateNotifier extends StateNotifier<DateTime> {
  DateStateNotifier(super.state);
}

final dateStateNotifier = StateNotifierProvider<DateStateNotifier, DateTime>(
    ((ref) => DateStateNotifier(DateTime.now())));
